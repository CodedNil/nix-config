{
  config,
  pkgs,
  inputs,
  lib,
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
    programs.git.lfs.enable = true;

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
            src =
              pkgs.fetchFromGitHub {
                owner = "ohitstom";
                repo = "spicetify-extensions";
                rev = "0fa2e593742011a29f8ec54c32bf642205ce82ff";
                hash = "sha256-w8viHMXhuXIlo1WJ94Jo2bWtYQr1RGviXZhVVm+rvns=";
              }
              + /quickQueue;
            name = "quickQueue.js";
          })
          ({
            src =
              pkgs.fetchFromGitHub {
                owner = "Konsl";
                repo = "spicetify-extensions";
                rev = "72c0a46c920748f86b3c731d72c64223b104f6de";
                hash = "sha256-9p8fz2KVRVkj3LT+zRRSETtVbxhAJ2Ar7aaM/1uQRBY=";
              }
              + /playback-bar-waveform/dist;
            name = "playback-bar-waveform.js";
          })
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

    # RUST High-performance code editor
    programs.zed-editor = {
      enable = true;
      extensions = [
        "nix"
        "toml"
        "html"
        "cargo-tom"
        "just"
      ];
      userSettings = {
        assistant = {
          enabled = true;
          version = "2";
          ### PROVIDER OPTIONS
          ### zed.dev models { claude-3-5-sonnet-latest } requires github connected
          ### copilot_chat models { gpt-4o gpt-4 gpt-3.5-turbo o1-preview } requires github
          default_model = {
            provider = "zed.dev";
            model = "claude-3-5-sonnet-latest";
          };
        };

        hour_format = "hour24";
        auto_update = false;

        lsp = {
          rust-analyzer.binary.path = lib.getExe pkgs.rust-analyzer;
        };

        theme = {
          mode = "system";
          light = "One Light";
          dark = "Andromeda";
        };
        show_whitespaces = "all";
        ui_font_size = 16;
        buffer_font_size = 16;
      };
    };

    # NixConfig shortcut
    xdg.desktopEntries.vscodeNixConfig = {
      name = "VSCode Nix Config";
      exec = "code /home/dan/nix-config";
      icon = ./icons/nixos.svg;
    };

    # Shortcuts to shutdown, reboot and logout
    xdg.desktopEntries.shutdown = {
      name = "Shutdown";
      exec = "systemctl poweroff";
      icon = ./configs/eww/icons/shutdown.svg;
    };
    xdg.desktopEntries.reboot = {
      name = "Reboot";
      exec = "systemctl reboot";
      icon = ./configs/eww/icons/reboot.svg;
    };
    xdg.desktopEntries.logout = {
      name = "Logout";
      exec = "niri msg action quit";
      icon = ./configs/eww/icons/lock.svg;
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

    # EasyEffects for noise suppression on microphone
    services.easyeffects.enable = true;

    # The state version is required and should stay at the version you originally installed.
    home.stateVersion = "24.11";
  };

  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    # Rust
    cargo # RUST Package manager
    rustc # RUST The rust compiler
    clippy # RUST Linter for rust
    rustfmt # RUST Formatter for rust
    rust-analyzer # RUST Language server for rust
    gcc # C++ Code linker
    trunk # RUST To compile WASM apps

    # Development
    vscode # CSS JS Code editor
    go # GO The go programming language
    nh # RUST Reimplements nix rebuild with visualised upgrade diff
    nixfmt-rfc-style # HASKELL Formatter for nix files
    jq # C Command line JSON processor
    codeium # Codeium language server for vscode

    # Misc
    gnome-text-editor # GTK4 C Simple text editor
    mission-center # GTK4 RUST System monitor
    blackbox-terminal # GTK4 VALA Terminal emulator
    seahorse # GTK4 C Gnome keyring manager

    # File Management
    nautilus # GTK4 C File manager
    ffmpegthumbnailer # C++ Enables video thumbnails
    gnome-disk-utility # GTK4 C Disk management utility
    baobab # GTK4 VALA Disk usage analyzer
    snoop # GTK4 VALA File searching

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

    # Creative
    gimp # GTK3 C Image editor
    inkscape # GTK3 C++ Vector editor
  ];
  programs.steam.enable = true;
  programs.nix-ld.enable = true; # Run unpatched binaries, required for codeium
  programs.nix-ld.libraries = [ ];

  # This value determines the NixOS release from which the default settings for stateful data, like file locations and database versions on your system were taken.
  system.stateVersion = "24.11";
}
