{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true; # Enable networking
  time.timeZone = "Europe/London"; # Set your time zone.

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable OpenGL
  hardware.graphics.enable = true;

  # Network drive mounts
  fileSystems."/mnt/ratatdan" = {
    device = "dan@135.181.161.182:/home/dan";
    fsType = "fuse.sshfs";
    options = [
      "_netdev"
      "users"
      "idmap=user"
      "allow_other"
      "IdentityFile=/home/dan/.ssh/id_ed25519"
    ];
  };
  fileSystems."/mnt/ratat" = {
    device = "plex@135.181.161.182:/home/plex";
    fsType = "fuse.sshfs";
    options = [
      "_netdev"
      "users"
      "idmap=user"
      "allow_other"
      "IdentityFile=/home/dan/.ssh/id_ed25519"
    ];
  };
  fileSystems."/mnt/raspi" = {
    device = "dan@86.9.117.105:/home/dan";
    fsType = "fuse.sshfs";
    options = [
      "_netdev"
      "users"
      "idmap=user"
      "allow_other"
      "IdentityFile=/home/dan/.ssh/id_ed25519"
      "port=2222"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable nixos flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable polkit agent
  security.soteria.enable = true;

  # Disable documentation building
  documentation.enable = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dan = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };
  services.gnome.gnome-keyring.enable = true;
  programs.dconf.enable = true;

  # Home manager
  home-manager.users.dan = {
    # Enable git
    programs.git = {
      enable = true;
      userName = "Dan Lock";
      userEmail = "codenil@proton.me";
    };

    # MPV media player with auto loop
    programs.mpv = {
      enable = true;
      config = {
        loop-file = "inf";
      };
    };

    # Equibop discord client
    xdg.configFile.equibop = {
      enable = true;
      source = ./equibop;
      target = "equibop";
      force = true;
      recursive = true;
    };

    # NixConfig shortcut
    xdg.desktopEntries.vscodeNixConfig = {
      name = "VSCode Nix Config";
      exec = "code /home/dan/nix-config";
      icon = ./icons/nixos.svg;
      type = "Application";
      categories = [ "Development" ];
    };

    # Shortcuts to shutdown, reboot and logout
    xdg.desktopEntries.shutdown = {
      name = "Shutdown";
      exec = "systemctl poweroff";
      icon = ./icons/shutdown.png;
      type = "Application";
      categories = [ "System" ];
    };
    xdg.desktopEntries.reboot = {
      name = "Reboot";
      exec = "systemctl reboot";
      icon = ./icons/reboot.png;
      type = "Application";
      categories = [ "System" ];
    };

    # Nautilus settings
    home.file."Templates/text.txt".text = "";
    dconf.settings = {
      "org/gtk/gtk4/settings/file-chooser" = {
        "show-hidden" = true;
        "sort-directories-first" = true;
      };
      "org/gnome/nautilus/icon-view" = {
        "default-zoom-level" = "extra-large";
      };
      "org/gnome/nautilus/list-view" = {
        "default-zoom-level" = "large";
      };
      "org/gnome/nautilus/preferences" = {
        "default-folder-viewer" = "icon-view";
      };
    };

    # EasyEffects for noise suppression on mic
    services.easyeffects.enable = true;

    # The state version is required and should stay at the version you originally installed.
    home.stateVersion = "24.11";
  };

  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    # Development
    rustup
    nixfmt-rfc-style
    gcc
    pkg-config
    trunk

    # Misc
    vscode
    gnome-maps
    gnome-text-editor
    mission-center
    blackbox-terminal
    seahorse
    mousam

    # File Management
    nautilus
    ffmpegthumbnailer
    diskonaut
    baobab
    snoop

    # Browsing
    inputs.zen-browser.packages."${system}".beta
    vivaldi
    tor-browser

    # Media
    loupe
    kdePackages.okular
    parabolic
    celluloid

    # Communication
    equibop
    # (discord.override {
    #   withOpenASAR = true;
    #   # withVencord = true;
    #   withEquicord = true;
    # })
    teamspeak5_client

    # Gaming
    prismlauncher

    # Creative
    gimp
    inkscape
  ];
  programs.steam.enable = true;
  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
    {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        hidePodcasts
        shuffle
        betterGenres
        beautifulLyrics
        starRatings
      ];
      theme = spicePkgs.themes.lucid;
    };

  # This value determines the NixOS release from which the default settings for stateful data, like file locations and database versions on your system were taken.
  system.stateVersion = "24.11";
}
