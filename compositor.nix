{
  pkgs,
  inputs,
  ...
}:

{
  # Enable the wayland windowing system.
  services.xserver.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Required packages
  environment.systemPackages = with pkgs; [
    xwayland-satellite
    wlr-randr
    playerctl
    bc
    bibata-cursors
  ];

  # Niri
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  # Keyd binds
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings.global = {
        overload_tap_timeout = 200; # Milliseconds to register a tap before timeout
      };
      settings.main = {
        compose = "layer(meta)"; # Make the menu key press super
        leftmeta = "overload(meta, macro(leftmeta+z))"; # Make left meta tap open anyrun keybind
        capslock = "macro(leftshift+tab)"; # Bind capslock to shift+tab
      };
    };
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

          default-column-width.proportion = 0.35;
          preset-column-widths = [
            { proportion = 0.35; }
            { proportion = 0.5; }
            { proportion = 0.7; }
          ];

          focus-ring = {
            enable = true;
            width = 2;
            active.gradient = {
              from = "#aa7a83";
              to = "#7a96aa";
              angle = 45;
              in' = "oklch longer hue";
              relative-to = "workspace-view";
            };
            inactive.color = "#505050";
          };
          border = {
            enable = true;
            width = 2;
            active.gradient = {
              from = "#aa7a83";
              to = "#7a96aa";
              angle = 45;
              in' = "oklch longer hue";
              relative-to = "workspace-view";
            };
            inactive.color = "#505050";
          };

          struts = {
            left = 40;
            right = 40;
          };
        };
        spawn-at-startup = [
          {
            command = [
              "xwayland-satellite"
              ":12"
            ];
          }
          {
            command = [
              "sh"
              "-c"
              "~/.config/eww/launch_eww"
            ];
          }
        ];
        environment = {
          "QT_QPA_PLATFORM" = "wayland";
          "DISPLAY" = ":12";
        };
        prefer-no-csd = true;
        hotkey-overlay.skip-at-startup = true;
        input.focus-follows-mouse.enable = true;
        cursor = {
          theme = "Bibata-Modern-Ice";
          size = 24;
        };
        window-rules =
          let
            createRule = app-id: proportion: {
              matches = [ { app-id = app-id; } ];
              default-column-width.proportion = proportion;
            };
          in
          [
            {
              clip-to-geometry = true;
              geometry-corner-radius = {
                top-left = 8.0;
                top-right = 8.0;
                bottom-left = 8.0;
                bottom-right = 8.0;
              };
            }
            {
              matches = [
                {
                  app-id = "org.kde.polkit-kde-authentication-agent-1";
                }
              ];
              open-floating = true;
            }
            (createRule "vivaldi" 0.6)
            (createRule "code" 0.5)
            (createRule "org.gnome.Nautilus" 0.42)
            (createRule "com.raggesilver.BlackBox" 0.3)
          ];
        binds = with config.lib.niri.actions; {
          "Mod+Shift+Slash".action = show-hotkey-overlay;

          # Application launchers
          "Mod+Z".action = spawn [
            "sh"
            "-c"
            "pkill anyrun || anyrun"
          ];
          "Mod+T".action = spawn "blackbox";
          "Mod+E".action = spawn "nautilus";
          "Mod+W".action = spawn "vivaldi";
          "Mod+S".action = spawn "spotify";
          "Mod+D".action = spawn "discord";
          "Mod+Shift+D".action = spawn "TeamSpeak";
          "Ctrl+Alt+Delete".action = spawn "missioncenter";

          "Mod+Q".action = close-window;

          # Print screen to take screenshot
          "Print".action = screenshot;
          "Ctrl+Print".action = screenshot-screen;
          "Alt+Print".action = screenshot-window;

          # Keybinds to exit
          "Mod+Escape".action = quit;
          "Mod+Shift+P".action = power-off-monitors;

          # Arrow keys to move focus, shift to move window with it
          "Mod+Left".action = focus-column-left;
          "Mod+Right".action = focus-column-right;
          "Mod+Down".action = focus-window-down;
          "Mod+Up".action = focus-window-up;

          "Mod+Shift+Left".action = move-column-left;
          "Mod+Shift+Right".action = move-column-right;
          "Mod+Shift+Down".action = move-window-down;
          "Mod+Shift+Up".action = move-window-up;

          "Mod+Ctrl+Down".action = focus-workspace-down;
          "Mod+Ctrl+Up".action = focus-workspace-up;

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
          "Mod+WheelScrollRight".action = move-column-right;
          "Mod+WheelScrollLeft".action = move-column-left;

          # Numbers to switch workspaces, shift to move window to workspace
          "Mod+1".action = focus-workspace 1;
          "Mod+2".action = focus-workspace 2;
          "Mod+3".action = focus-workspace 3;
          "Mod+4".action = focus-workspace 4;
          "Mod+Shift+1".action = move-column-to-workspace 1;
          "Mod+Shift+2".action = move-column-to-workspace 2;
          "Mod+Shift+3".action = move-column-to-workspace 3;
          "Mod+Shift+4".action = move-column-to-workspace 4;

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

          # Capslock
          # "Caps_Lock".action = spawn [
          #   "swayosd-client"
          #   "--caps-lock"
          #   "toggle"
          # ];

          # Audio controls
          "XF86AudioRaiseVolume".action = spawn [
            "swayosd-client"
            "--output-volume"
            "raise"
          ];
          "XF86AudioLowerVolume".action = spawn [
            "swayosd-client"
            "--output-volume"
            "lower"
          ];
          "XF86AudioMute".action = spawn [
            "swayosd-client"
            "--output-volume"
            "mute-toggle"
          ];
          "XF86AudioMicMute".action = spawn [
            "swayosd-client"
            "--input-volume"
            "mute-toggle"
          ];
          "XF86AudioPlay".action = spawn [
            "playerctl"
            "play-pause"
          ];
          "XF86AudioPrev".action = spawn [
            "playerctl"
            "previous"
          ];
          "XF86AudioNext".action = spawn [
            "playerctl"
            "next"
          ];

          # Brightness
          "XF86MonBrightnessUp".action = spawn [
            "swayosd-client"
            "--brightness"
            "raise"
          ];
          "XF86MonBrightnessDown".action = spawn [
            "swayosd-client"
            "--brightness"
            "lower"
          ];
        };
      };

      # Notification daemon
      services.mako.enable = true;

      # Widgets and bars
      programs.eww = {
        enable = true;
        configDir = ./configs/eww;
      };

      # On screen display
      services.swayosd = {
        enable = true;
        display = "HDMI-A-1";
        stylePath = ./configs/swayosd.css;
      };

      # Application launcher
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

        extraCss = builtins.readFile ./configs/anyrun.css;
        extraConfigFiles."applications.ron".text = ''
          Config(
            desktop_actions: false,
            max_entries: 5,
            terminal: None,
          )
        '';
        extraConfigFiles."shell.ron".text = ''
          Config(
            prefix: "",
            shell: Some("fish"),
          )
        '';
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

      # Theme GTK Apps
      gtk = {
        enable = true;
        cursorTheme = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
          size = 24;
        };
        iconTheme = {
          package = pkgs.adwaita-icon-theme;
          name = "Adwaita";
        };
        theme = {
          name = "Adwaita";
        };
      };
    };
}
