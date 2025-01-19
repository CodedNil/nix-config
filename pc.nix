{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./pc-hardware.nix # Include the results of the hardware scan.
  ];

  networking.hostName = "dan-pc";
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Load Nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false; # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.finegrained = false; # Fine-grained power management. Turns off GPU when not in use.
    open = true; # Use the NVidia open source kernel module
    nvidiaSettings = true; # Enable the Nvidia settings menu, accessible via `nvidia-settings`.
    package = config.boot.kernelPackages.nvidiaPackages.stable; # Optionally, you may need to select the appropriate driver version for your specific GPU.
  };

  # Vault drive mount
  fileSystems."/mnt/vault" = {
    device = "/dev/disk/by-uuid/8a4efbd6-f7c4-4baf-ae29-df8f5835e127";
    fsType = "btrfs";
  };

  home-manager.users.dan = {
    # Niri

    # ┌────────────────────────────────────┐
    # │                                    │
    # │              HDMI-A-1              │
    # │            3840x2160@120           │
    # │                                    │
    # │                                    │ ┌──────────────┐
    # │                                    │ │   HDMI-A-2   │
    # │                                    │ │ 1920x1080@60 │
    # │                                    │ │              │
    # └────────────────────────────────────┘ └──────────────┘

    programs.niri.settings.outputs = {
      "HDMI-A-1" = {
        mode = {
          width = 3840;
          height = 2160;
          refresh = 120.0;
        };
        position = {
          x = 0;
          y = 0;
        };
        scale = 1.25;
        variable-refresh-rate = true;
        background-color = "#000000";
      };
      "HDMI-A-2" = {
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.0;
        };
        position = {
          x = builtins.floor (3840 / 1.25);
          y = builtins.floor (1080 / 1.25);
        };
        scale = 1.25;
        background-color = "#000000";
      };
    };

    # Workspaces
    programs.niri.settings.workspaces = {
      a_primary.open-on-output = "HDMI-A-1";
      b_secondary.open-on-output = "HDMI-A-1";

      a_spotify.open-on-output = "HDMI-A-2";
      b_chat.open-on-output = "HDMI-A-2";
    };

    # Window rules
    programs.niri.settings.window-rules = [
      {
        matches = [
          {
            app-id = "spotify";
          }
        ];
        open-on-workspace = "a_spotify";
        open-maximized = true;
        open-fullscreen = false;
        open-floating = false;
        open-focused = false;
      }
      {
        matches = [
          {
            app-id = "discord";
          }
        ];
        default-column-width.proportion = 0.75;
        open-on-workspace = "b_chat";
        open-focused = true;
      }
      {
        matches = [
          {
            app-id = "TeamSpeak";
          }
        ];
        default-column-width.proportion = 0.25;
        open-on-workspace = "b_chat";
        open-focused = true;
      }
    ];

    # Spawn programs
    programs.niri.settings.spawn-at-startup = [
      {
        command = [
          "spotify"
        ];
      }
    ];

    # Fish functions
    programs.fish.functions.enc = ''
      # Mount using cryfs
      cryfs /mnt/vault/Enc /mnt/vault/EncMnt --blocksize 131072

      # Set up a trap to run clean-up when the script is interrupted
      function cleanup
        echo "Cleaning up..."
        rm -rf ~/.cache/thumbnails
        rm -rf ~/.local/share/Trash/files
        rm -rf ~/.local/share/Trash/info
        rm -rf ~/Pictures/Screenshots
        rm -f ~/.bash_history
        rm -f ~/.local/share/fish/fish_history
        wl-copy --clear
        atuin search --delete-it-all
        cryfs-unmount /mnt/vault/EncMnt
      end
      trap cleanup EXIT

      # Wait indefinitely until interrupted
      read -P "Vault mounted. Press Ctrl+C to unmount and clean up."
      cleanup
    '';

    # Nautilus file manager bookmarks
    gtk.gtk3.bookmarks = [
      "file:///home/dan/Downloads Downloads"
      "file:///home/dan/Documents Documents"
      "file:///mnt/vault vault"
      # "file:///mnt/raspi raspi"
      # "file:///mnt/ratat ratat"
      # "file:///mnt/ratatdan ratatdan"
    ];
  };
}
