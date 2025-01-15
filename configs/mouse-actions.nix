{
  programs.ydotool.enable = true;
  programs.mouse-actions = {
    enable = true;
    autorun = true;
  };
  environment.systemPackages = [
    pkgs.mouse-actions-gui
  ];

  home-manager.users.dan = {
    xdg.configFile."mouse-actions.json".text = builtins.toJSON {
      shape_button = "Right";
      bindings = let
        halfCircleShape = flip:
          let
            stepSize = 100;
            topY = 0;
            bottomY = 1000;
            path = concatMap (y: [
              { x = -flip * round (y * 0.1); y = y; }
              { x = -flip * round ((bottomY - y) * 0.1); y = bottomY - (y - topY); }
            ]) (builtins.genList (n: topY + n * stepSize) ((bottomY - topY) / stepSize / 2));
          in [{ x = 0; y = topY; }] ++ path;

        straightLineShape = (dx, dy): [
          for offset in [0, 100..1000]: { x = dx * offset; y = dy * offset; }
        ];

        createBinding = { comment, button, type, shape ? [], cmd }:
          {
            comment = comment;
            button = button;
            event_type = type;
            shapes_xy = shape;
            cmd_str = cmd;
          };
        
        gestures = [
          { comment = "New tab"; button = "Right"; type = "Shape"; shape = straightLineShape (0, 1); cmd = "ydotool key ctrl+t"; }
          { comment = "Close tab"; button = "Right"; type = "Shape"; shape = halfCircleShape 1; cmd = "ydotool key ctrl+w"; }
          { comment = "Reopen tab"; button = "Right"; type = "Shape"; shape = halfCircleShape -1; cmd = "ydotool key shift+ctrl+t"; }
          { comment = "Next tab"; button = "Right"; type = "Click"; cmd = "ydotool key ctrl+tab"; }
          { comment = "Previous tab"; button = "Right"; type = "Click"; cmd = "ydotool key ctrl+shift+tab"; }
          { comment = "Focus column right"; button = "Right"; type = "Shape"; shape = straightLineShape (1, 0); cmd = "niri msg focus-column-right"; }
          { comment = "Focus column left"; button = "Right"; type = "Shape"; shape = straightLineShape (-1, 0); cmd = "niri msg focus-column-left"; }
          { comment = "Move column left"; button = "Middle"; type = "Shape"; shape = straightLineShape (-1, 0); cmd = "niri msg move-column-left"; }
          { comment = "Move column right"; button = "Middle"; type = "Shape"; shape = straightLineShape (1, 0); cmd = "niri msg move-column-right"; }
          { comment = "Move column to workspace up"; button = "Middle"; type = "Shape"; shape = straightLineShape (0, -1); cmd = "niri msg move-column-to-workspace-up"; }
          { comment = "Move column to workspace down"; button = "Middle"; type = "Shape"; shape = straightLineShape (0, 1); cmd = "niri msg move-column-to-workspace-down"; }
          { comment = "Launch anyrun"; button = "Right"; type = "Shape"; shape = straightLineShape (0, -1); cmd = "anyrun"; }
        ];

      in map createBinding gestures;
    };
  };
}