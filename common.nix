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

  # Enable the wayland windowing system.
  services.xserver.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enable the Cosmic Desktop Environment.
  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;
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

  # Niri
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
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
    {
      pkgs,
      config,
      ...
    }:
    {
      home.packages = [ ];

      # Niri
      programs.niri.settings.binds = with config.lib.niri.actions; {
        "Mod+Shift+Slash".action = show-hotkey-overlay;

        "Mod+T".action = spawn "blackbox";
        "Mod+D".action = spawn "fuzzel";
        "Super+Alt+L".action = spawn "swaylock";

        "Mod+Q".action = close-window;
        "Mod+Left".action = focus-column-left;
        "Mod+Down".action = focus-window-down;
        "Mod+Up".action = focus-window-up;
        "Mod+Right".action = focus-column-right;
        "Mod+H".action = focus-column-left;
        "Mod+J".action = focus-window-down;
        "Mod+K".action = focus-window-up;
        "Mod+L".action = focus-column-right;

        "Mod+Ctrl+Left".action = move-column-left;
        "Mod+Ctrl+Down".action = move-window-down;
        "Mod+Ctrl+Up".action = move-window-up;
        "Mod+Ctrl+Right".action = move-column-right;
        "Mod+Ctrl+H".action = move-column-left;
        "Mod+Ctrl+J".action = move-window-down;
        "Mod+Ctrl+K".action = move-window-up;
        "Mod+Ctrl+L".action = move-column-right;

        "Mod+Home".action = focus-column-first;
        "Mod+End".action = focus-column-last;
        "Mod+Ctrl+Home".action = move-column-to-first;
        "Mod+Ctrl+End".action = move-column-to-last;

        "Mod+Shift+Left".action = focus-monitor-left;
        "Mod+Shift+Down".action = focus-monitor-down;
        "Mod+Shift+Up".action = focus-monitor-up;
        "Mod+Shift+Right".action = focus-monitor-right;
        "Mod+Shift+H".action = focus-monitor-left;
        "Mod+Shift+J".action = focus-monitor-down;
        "Mod+Shift+K".action = focus-monitor-up;
        "Mod+Shift+L".action = focus-monitor-right;

        "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
        "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

        "Mod+Page_Down".action = focus-workspace-down;
        "Mod+Page_Up".action = focus-workspace-up;
        "Mod+U".action = focus-workspace-down;
        "Mod+I".action = focus-workspace-up;
        "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
        "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
        "Mod+Ctrl+U".action = move-column-to-workspace-down;
        "Mod+Ctrl+I".action = move-column-to-workspace-up;

        "Mod+Shift+Page_Down".action = move-workspace-down;
        "Mod+Shift+Page_Up".action = move-workspace-up;
        "Mod+Shift+U".action = move-workspace-down;
        "Mod+Shift+I".action = move-workspace-up;

        "Mod+WheelScrollDown".action = focus-workspace-down;
        "Mod+WheelScrollDown".cooldown-ms = 150;
        "Mod+WheelScrollUp".action = focus-workspace-up;
        "Mod+WheelScrollUp".cooldown-ms = 150;
        "Mod+Ctrl+WheelScrollDown".action = move-column-to-workspace-down;
        "Mod+Ctrl+WheelScrollDown".cooldown-ms = 150;
        "Mod+Ctrl+WheelScrollUp".action = move-column-to-workspace-up;
        "Mod+Ctrl+WheelScrollUp".cooldown-ms = 150;

        "Mod+WheelScrollRight".action = focus-column-right;
        "Mod+WheelScrollLeft".action = focus-column-left;
        "Mod+Ctrl+WheelScrollRight".action = move-column-right;
        "Mod+Ctrl+WheelScrollLeft".action = move-column-left;

        "Mod+Shift+WheelScrollDown".action = focus-column-right;
        "Mod+Shift+WheelScrollUp".action = focus-column-left;
        "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
        "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;

        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;

        "Mod+Ctrl+1".action = move-column-to-workspace 1;
        "Mod+Ctrl+2".action = move-column-to-workspace 2;
        "Mod+Ctrl+3".action = move-column-to-workspace 3;
        "Mod+Ctrl+4".action = move-column-to-workspace 4;
        "Mod+Ctrl+5".action = move-column-to-workspace 5;
        "Mod+Ctrl+6".action = move-column-to-workspace 6;
        "Mod+Ctrl+7".action = move-column-to-workspace 7;
        "Mod+Ctrl+8".action = move-column-to-workspace 8;
        "Mod+Ctrl+9".action = move-column-to-workspace 9;

        "Mod+BracketLeft".action = consume-or-expel-window-left;
        "Mod+BracketRight".action = consume-or-expel-window-right;
        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;

        "Mod+R".action = switch-preset-column-width;
        "Mod+Shift+R".action = switch-preset-window-height;
        "Mod+Ctrl+R".action = reset-window-height;

        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+C".action = center-column;

        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";

        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";

        "Mod+V".action = toggle-window-floating;
        "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

        "Print".action = screenshot;
        "Ctrl+Print".action = screenshot-screen;
        "Alt+Print".action = screenshot-window;

        "Mod+Shift+E".action = quit;
        "Ctrl+Alt+Delete".action = quit;

        "Mod+Shift+P".action = power-off-monitors;
      };
      programs.niri.settings.layout = {
        gaps = 16;

        center-focused-column = "never";

        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];

        default-column-width = {
          proportion = 0.5;
        };

        focus-ring = {
          width = 4;
          active = {
            color = "#7fc8ff";
          };
          inactive = {
            color = "#505050";
          };
        };

        border = {
          enable = false;
          width = 4;
          active = {
            color = "#ffc87f";
          };
          inactive = {
            color = "#505050";
          };
        };
      };

      # System
      services.mako = {
        enable = true;
      };
      programs.waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
          };
        };
        systemd.enable = true;
      };
      programs.fuzzel = {
        enable = true;
      };

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

      # Web Apps
      xdg.desktopEntries.outlook = {
        name = "Outlook";
        exec = "vivaldi --app=https://outlook.office365.com/mail/";
        icon = ./icons/outlook.svg;
        type = "Application";
        categories = [
          "Office"
          "Email"
          "Calendar"
        ];
      };
      xdg.desktopEntries.teams = {
        name = "Teams";
        exec = "vivaldi --app=https://teams.microsoft.com/v2/";
        icon = ./icons/teams.svg;
        type = "Application";
        categories = [
          "Office"
          "Chat"
          "InstantMessaging"
          "VideoConference"
        ];
      };
      xdg.desktopEntries.todo = {
        name = "Todo";
        exec = "vivaldi --app=https://to-do.office.com/tasks/assigned_to_me";
        icon = ./icons/todo.svg;
        type = "Application";
        categories = [
          "Office"
          "ProjectManagement"
        ];
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
    vscode
    rustup
    nixfmt-rfc-style
    gcc
    pkg-config
    trunk
    nerd-fonts.fira-code

    # Utilities
    blackbox
    just
    bottom
    mission-center
    seahorse
    fend
    tokei
    wl-clipboard
    gnome-maps
    gnome-text-editor

    # File Management
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
    celluloid

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
