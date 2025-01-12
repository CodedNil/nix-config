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
