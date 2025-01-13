{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./work-hardware.nix # Include the results of the hardware scan.
  ];

  networking.hostName = "dan-work"; # Define your hostname.
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  home-manager.users.dan = {
    # Niri

    #                       +------------------------+
    # +--------------------+|                        |
    # |                    ||          DP-7          |
    # |        DP-6        ||      2560x1440@120     |
    # |    1920x1080@60    ||                        |
    # |                    ||                        |
    # |                    ||                        |
    # +--------------------++------------------------+
    #               +--------------+
    #               |              |
    #               |    eDP-1     |
    #               | 2256x1504@60 |
    #               |              |
    #               +--------------+

    programs.niri.settings.outputs = {
      "eDP-1" = {
        mode = {
          width = 2256;
          height = 1504;
          refresh = 60.0;
        };
        position = {
          x = 0;
          y = 0;
        };
        scale = 1.5;
        background-color = "#000000";
      };
      "DP-6" = {
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.0;
        };
        position = {
          x = builtins.floor (-1920 / 2.0);
          y = builtins.floor (-1504 / 1.5 - 1080 / 2.0);
        };
        scale = 1.0;
        background-color = "#000000";
      };
      "DP-7" = {
        mode = {
          width = 2560;
          height = 1440;
          refresh = 120.0;
        };
        position = {
          x = builtins.floor (2560 / 2.0 / 1.25);
          y = builtins.floor (-1504 / 1.5 - 1440 / 2.0 / 1.25);
        };
        scale = 1.25;
        background-color = "#000000";
      };
    };
    programs.niri.settings.window-rules = [
      {
        matches = [
          {
            app-id = "vivaldi";
            title = ".*Outlook.*";
          }
        ];
        open-on-output = "DP-6";
        open-maximized = false;
        open-fullscreen = false;
        open-floating = false;
        open-focused = false;
        default-column-width.proportion = 0.7;
      }
      {
        matches = [
          {
            app-id = "vivaldi";
            title = ".*To Do.*";
          }
        ];
        open-on-output = "DP-6";
        open-maximized = false;
        open-fullscreen = false;
        open-floating = false;
        open-focused = false;
        default-column-width.proportion = 0.3;
      }
      {
        matches = [
          {
            app-id = "vivaldi";
            title = ".*"; # Matches any standard Vivaldi window
          }
        ];
        open-on-output = "DP-7";
        open-maximized = true;
        open-fullscreen = false;
        open-floating = false;
        open-focused = false;
      }
    ];
    programs.niri.settings.spawn-at-startup = map (cmd: { command = [ cmd ]; }) [
      "vivaldi"
      "vivaldi --app=https://outlook.office365.com/mail/"
      "vivaldi --app=https://to-do.office.com/tasks/assigned_to_me"
    ];

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
  };
}
