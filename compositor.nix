{
  pkgs,
  inputs,
  ...
}:

{
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

  # Niri
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  home-manager.users.dan =
    {
      config,
      ...
    }:
    {
      # Niri
      programs.niri.settings = {
        layout = {
          gaps = 16;

          always-center-single-column = true;
          center-focused-column = "never";

          # default-column-width = {
          #   proportion = 0.8;
          # };
          preset-column-widths = [
            { proportion = 0.35; }
            { proportion = 0.6; }
            { proportion = 0.8; }
          ];

          focus-ring = {
            enable = true;
            width = 4;
            # active.color = "#7fc8ff";
            inactive.color = "#505050";
            active.gradient = {
              from = "#aa7a83";
              to = "#7a96aa";
              angle = 45;
              in' = "oklch longer hue";
              relative-to = "workspace-view";
            };
          };
          border = {
            enable = false;
            width = 4;
            active.color = "#ffc87f";
            inactive.color = "#505050";
          };
        };
        spawn-at-startup = map (cmd: { command = [ cmd ]; }) [
          # "xwayland-satellite"
          # "~/.config/eww/launch_bar"
        ];
        prefer-no-csd = true;
        # environment.DISPLAY = ":0";
        input.focus-follows-mouse.enable = true;
        window-rules = [
          {
            clip-to-geometry = true;
            geometry-corner-radius = {
              top-left = 8.0;
              top-right = 8.0;
              bottom-left = 8.0;
              bottom-right = 8.0;
            };
          }
        ];
        binds = with config.lib.niri.actions; {
          "Mod+Shift+Slash".action = show-hotkey-overlay;

          # Application launchers
          "Mod+D".action = spawn "pkill anyrun || anyrun";
          "Mod+T".action = spawn "blackbox";
          "Mod+E".action = spawn "nautilus";
          "Mod+Y".action = spawn "vivaldi";
          "Mod+S".action = spawn "spotify";

          "Mod+Q".action = close-window;
          "Mod+Escape".action = close-window;

          # Print screen to take screenshot
          "Print".action = screenshot;
          "Ctrl+Print".action = screenshot-screen;
          "Alt+Print".action = screenshot-window;

          # Keybinds to exit
          "Mod+Shift+E".action = quit;
          "Ctrl+Alt+Delete".action = quit;
          "Mod+Shift+P".action = power-off-monitors;

          # Arrow keys to move focus, shift to move window with it
          "Mod+Left".action = focus-column-left;
          "Mod+Down".action = focus-window-down;
          "Mod+Up".action = focus-window-up;
          "Mod+Right".action = focus-column-right;

          "Mod+Shift+Left".action = move-column-left;
          "Mod+Shift+Down".action = move-window-down;
          "Mod+Shift+Up".action = move-window-up;
          "Mod+Shift+Right".action = move-column-right;

          # Arrow keys with control to move focus between monitors, shift to move window with it
          "Mod+Ctrl+Left".action = focus-monitor-left;
          "Mod+Ctrl+Down".action = focus-monitor-down;
          "Mod+Ctrl+Up".action = focus-monitor-up;
          "Mod+Ctrl+Right".action = focus-monitor-right;

          "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
          "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
          "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
          "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;

          # Page keys to move focus and columns
          "Mod+Page_Down".action = focus-workspace-down;
          "Mod+Page_Up".action = focus-workspace-up;
          "Mod+Ctrl+Page_Down".action = move-column-to-workspace-down;
          "Mod+Ctrl+Page_Up".action = move-column-to-workspace-up;
          "Mod+Shift+Page_Down".action = move-workspace-down;
          "Mod+Shift+Page_Up".action = move-workspace-up;

          # Scroll to move focus and columns, shift to move window with it
          "Mod+WheelScrollDown".action = focus-column-right;
          "Mod+WheelScrollUp".action = focus-column-left;
          "Mod+Shift+WheelScrollDown".action = move-column-right;
          "Mod+Shift+WheelScrollUp".action = move-column-left;

          # Scroll with control to switch workspaces, shift to move window with it
          "Mod+Ctrl+WheelScrollDown".action = focus-workspace-down;
          "Mod+Ctrl+WheelScrollDown".cooldown-ms = 150;
          "Mod+Ctrl+WheelScrollUp".action = focus-workspace-up;
          "Mod+Ctrl+WheelScrollUp".cooldown-ms = 150;
          "Mod+Shift+Ctrl+WheelScrollDown".action = move-column-to-workspace-down;
          "Mod+Shift+Ctrl+WheelScrollDown".cooldown-ms = 150;
          "Mod+Shift+Ctrl+WheelScrollUp".action = move-column-to-workspace-up;
          "Mod+Shift+Ctrl+WheelScrollUp".cooldown-ms = 150;

          # Left and right scroll to move focus and columns, shift to move window with it
          "Mod+WheelScrollRight".action = focus-column-right;
          "Mod+WheelScrollLeft".action = focus-column-left;
          "Mod+Ctrl+WheelScrollRight".action = move-column-right;
          "Mod+Ctrl+WheelScrollLeft".action = move-column-left;

          # Numbers to switch workspaces, shift to move window to workspace
          "Mod+1".action = focus-workspace 1;
          "Mod+2".action = focus-workspace 2;
          "Mod+3".action = focus-workspace 3;
          "Mod+4".action = focus-workspace 4;
          "Mod+5".action = focus-workspace 5;
          "Mod+6".action = focus-workspace 6;
          "Mod+7".action = focus-workspace 7;
          "Mod+8".action = focus-workspace 8;
          "Mod+9".action = focus-workspace 9;
          "Mod+Shift+1".action = move-column-to-workspace 1;
          "Mod+Shift+2".action = move-column-to-workspace 2;
          "Mod+Shift+3".action = move-column-to-workspace 3;
          "Mod+Shift+4".action = move-column-to-workspace 4;
          "Mod+Shift+5".action = move-column-to-workspace 5;
          "Mod+Shift+6".action = move-column-to-workspace 6;
          "Mod+Shift+7".action = move-column-to-workspace 7;
          "Mod+Shift+8".action = move-column-to-workspace 8;
          "Mod+Shift+9".action = move-column-to-workspace 9;

          # Bracket keys, comma and period to consume or expel windows
          "Mod+BracketLeft".action = consume-or-expel-window-left;
          "Mod+BracketRight".action = consume-or-expel-window-right;
          "Mod+Comma".action = consume-window-into-column;
          "Mod+Period".action = expel-window-from-column;

          # R to switch window widths, shift to switch window heights, control to reset
          "Mod+R".action = switch-preset-column-width;
          "Mod+Shift+R".action = switch-preset-window-height;
          "Mod+Ctrl+R".action = reset-window-height;

          # F to maximize, shift F to fullscreen, C to center
          "Mod+F".action = maximize-column;
          "Mod+Shift+F".action = fullscreen-window;
          "Mod+C".action = center-column;

          # Plus and minus to adjust column width, shift to adjust window height
          "Mod+Minus".action = set-column-width "-10%";
          "Mod+Equal".action = set-column-width "+10%";
          "Mod+Shift+Minus".action = set-window-height "-10%";
          "Mod+Shift+Equal".action = set-window-height "+10%";

          # V to toggle floating, shift V to switch focus between floating and tiling
          "Mod+V".action = toggle-window-floating;
          "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

          # Audio controls
          "XF86AudioRaiseVolume".action = spawn [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1+"
          ];
          "XF86AudioLowerVolume".action = spawn [
            "wpctl"
            "set-volume"
            "@DEFAULT_AUDIO_SINK@"
            "0.1-"
          ];
          "XF86AudioMute".action = spawn [
            "wpctl"
            "toggle-mute"
            "@DEFAULT_AUDIO_SINK@"
          ];
        };
      };

      # System
      services.mako.enable = true;
      programs.eww = {
        enable = true;
        configDir = ./eww;
      };
      services.swayosd = {
        enable = true;
        display = "HDMI-A-1";
      };

      imports = [ inputs.anyrun.homeManagerModules.default ];
      programs.anyrun = {
        enable = true;
        config = {
          x = {
            fraction = 0.5;
          };
          y = {
            fraction = 0.3;
          };
          width = {
            fraction = 0.3;
          };
          hideIcons = false;
          ignoreExclusiveZones = false;
          layer = "overlay";
          hidePluginInfo = true;
          closeOnClick = true;
          showResultsImmediately = false;
          maxEntries = 20;

          plugins = [
            inputs.anyrun.packages.${pkgs.system}.applications
            inputs.anyrun.packages.${pkgs.system}.rink
            inputs.anyrun.packages.${pkgs.system}.shell
            inputs.anyrun.packages.${pkgs.system}.dictionary
            inputs.anyrun.packages.${pkgs.system}.websearch
          ];
        };

        extraCss = builtins.readFile ./anyrun.css;
        extraConfigFiles."dictionary.ron".text = ''
          Config(
            prefix: "define",
            max_entries: 5,
          )
        '';
        extraConfigFiles."websearch.ron".text = ''
          Config(
            prefix: "",
            engines: [Custom(
              name: "DuckDuckGo",
              url: "https://duckduckgo.com/?q={}",
            )],
          )
        '';
      };
    };

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    wlr-randr
  ];
}
