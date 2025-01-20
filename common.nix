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

  # Enable greeter
  services.xserver.displayManager.gdm.enable = true;

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

  # Enable key services
  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;
  programs.dconf.enable = true;
  xdg.mime.enable = true;
  xdg.icons.enable = true;

  # Disable building documentation
  documentation.enable = false;
  documentation.man.generateCaches = false;

  # Disable some default packages
  services.xserver.excludePackages = [
    pkgs.xterm
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dan = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };

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

    # App specific configs
    imports = [
      ./configs/discord.nix
      ./configs/zen/zen.nix
    ];

    # Spicetify
    programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        enable = true;
        alwaysEnableDevTools = true;
        enabledExtensions = with spicePkgs.extensions; [
          hidePodcasts
          shuffle
          beautifulLyrics
          starRatings
          ({
            src = ./configs;
            name = "spicetify.js";
          })
        ];
        theme = {
          name = "Lucid";
          src =
            pkgs.fetchFromGitHub {
              owner = "sanoojes";
              repo = "Spicetify-Lucid";
              rev = "dc0616a616608442d62da4821a9f85ebc12578d0";
              hash = "sha256-kWBaSH9n24ClNehSeMhT6Sa41vwu2rVsFsJzwuXBDJI=";
            }
            + /src;
          overwriteAssets = true;
        };
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
      icon = ./configs/eww/icons/shutdown.svg;
      type = "Application";
      categories = [ "System" ];
    };
    xdg.desktopEntries.reboot = {
      name = "Reboot";
      exec = "systemctl reboot";
      icon = ./configs/eww/icons/reboot.svg;
      type = "Application";
      categories = [ "System" ];
    };
    xdg.desktopEntries.logout = {
      name = "Logout";
      exec = "niri msg action quit";
      icon = ./configs/eww/icons/lock.svg;
      type = "Application";
      categories = [ "System" ];
    };

    # Nautilus settings
    home.file."Templates/text.txt".text = "";
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        "color-scheme" = "prefer-dark";
      };
      "org.gnome.desktop.privacy" = {
        "remember-app-usage" = "false";
        "remember-recent-files" = "false";
      };
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
      "org/gnome/TextEditor" = {
        "restore-session" = false;
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
    rustup # RUST Installer for rust
    go # GO The go programming language
    nh # RUST Reimplements nix rebuild with visualised upgrade diff
    nixfmt-rfc-style # HASKELL Formatter for nix files
    trunk # RUST To compile WASM apps
    gcc # C++ code linker
    jq # C Command line JSON processor

    # Misc
    vscode # CSS JS Code editor
    gnome-maps # GTK4 JS Maps viewer
    gnome-text-editor # GTK4 C Simple text editor
    mission-center # GTK4 RUST System monitor
    blackbox-terminal # GTK4 VALA Terminal emulator
    seahorse # GTK4 C Gnome keyring manager
    mousam # GTK4 PYTHON Pretty weather viewer

    # File Management
    nautilus # GTK4 C File manager
    ffmpegthumbnailer # Enables video thumbnails
    gnome-disk-utility # GTK4 C Disk management utility
    diskonaut # TRM RUST Disk usage analyzer in terminal
    baobab # GTK4 VALA Disk usage analyzer
    snoop # GTK4 VALA File searching
    dconf-editor # GTK4 Vala Configuration editor

    # Browsing
    inputs.zen-browser.packages."${system}".default # CSS JS Web browser
    vivaldi # CSS JS Web browser
    tor-browser # CSS JS Web browser

    # Media
    loupe # GTK4 RUST Image viewer
    kdePackages.okular # QT C++ Document viewer
    parabolic # GTK4 C++ Video downloader
    celluloid # GTK4 C Video player

    # Communication
    teamspeak5_client # Voice chat client

    # Gaming
    prismlauncher # Minecraft launcher

    # Creative
    gimp # GTK3 C Image editor
    inkscape # GTK3 C++ Vector editor
  ];
  programs.steam.enable = true;

  # This value determines the NixOS release from which the default settings for stateful data, like file locations and database versions on your system were taken.
  system.stateVersion = "24.11";
}
