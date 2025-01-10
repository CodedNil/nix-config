{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.spicetify-nix.nixosModules.default
  ];

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

  # Enable the wayland windowing system.
  services.xserver.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enable the Cosmic Desktop Environment.
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-store
    cosmic-player
  ];

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
  home-manager.users.dan =
    { pkgs, ... }:
    {
      home.packages = [ ];

      # Enable git
      programs.git = {
        enable = true;
        userName = "Dan Lock";
        userEmail = "codenil@proton.me";
      };

      # Fish and compatible programs
      programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting # Disable greeting
        '';
        shellAliases = {
          cd = "z";
          cat = "bat";
          ls = "eza";
          find = "fd";
          raspi = "ssh dan@86.9.117.105 -p 2222";
          ratatdan = "ssh dan@135.181.161.182";
          ratatplex = "ssh plex@135.181.161.182";
        };
      };
      programs.starship = {
        enable = true;
        enableFishIntegration = true;
      };
      programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
      };
      programs.atuin = {
        enable = true;
        enableFishIntegration = true;
      };

      # MPV media player with auto loop
      programs.mpv = {
        enable = true;
        config = {
          loop-file = "inf";
        };
      };

      # Equibop discord client
      xdg.configFile = {
        equibopSettings = {
          enable = true;
          source = ./equibop;
          target = "equibop";
          force = true;
          recursive = true;
        };
      };

      # The state version is required and should stay at the version you originally installed.
      home.stateVersion = "24.11";
    };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable nixos flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    # Development
    rustup
    nixfmt-rfc-style
    gcc
    pkg-config
    trunk
    nerd-fonts.fira-code

    # Utilities
    just
    bottom
    mission-center
    seahorse
    fend
    tokei

    # File Management
    vscode
    nautilus
    cryfs
    sshfs
    ffmpegthumbnailer
    diskonaut
    baobab
    yazi
    eza
    bat
    fd

    # Browsing
    inputs.zen-browser.packages."${system}".beta # NoHighlightSplit, FloatingStatusBar, NoSearchShortcutIcons, BetterTabIndicators, FluidURL, OnlyCloseOnHover, SuperPins, SuperUrlBar, AnimationsPlus, Quietify, CleanerExtensionMenu, BetterFindBar, FloatingHistory, TabPreviewEnhanced, LoadBar
    # browser.sesionstore.restore_on_demand browser.sessionstore.restore_pinned_tabs_on_demand browser.sessionstore.restore_tabs_lazily
    vivaldi
    tor-browser

    # Media
    loupe
    kdePackages.okular
    parabolic

    # Communication
    equibop
    teamspeak5_client
    easyeffects

    # Gaming
    prismlauncher

    # Creative
    gimp
    inkscape
  ];
  programs.fish.enable = true;
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
        sectionMarker
      ];
      theme = spicePkgs.themes.lucid;
    };

  # This value determines the NixOS release from which the default settings for stateful data, like file locations and database versions on your system were taken.
  system.stateVersion = "24.11";
}
