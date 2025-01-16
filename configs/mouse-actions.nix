{
  pkgs,
  lib,
  ...
}:

{
  programs.ydotool.enable = true;
  environment.systemPackages = with pkgs; [
    mouse-actions
    mouse-actions-gui
  ];

  home-manager.users.dan = {
    xdg.configFile."mouse-actions.json".text = builtins.toJSON {
      shape_button = "Right";
      bindings =
        let
          # Function to generate a list of coordinate pairs based on x and y
          # If x is 1 then it does 0..1000, if x is -1 it will be 1000..0, and same for y, 0 will be 0..0
          straightLineShape =
            x: y:
            # Define the steps for x and y based on the provided input.
            let
              totalSteps = 11;
              stepValue = 1000 / (totalSteps - 1);
              # Function to calculate the value based on step direction.
              generateSeq =
                step:
                if step == 0 then
                  # If step is 0, all values are the same.
                  builtins.genList (_: 0) totalSteps
                else if step > 0 then
                  # Generate list from 0 -> 1000
                  builtins.genList (i: i * stepValue) totalSteps
                else
                  builtins.genList (i: 1000 - i * stepValue) totalSteps;
              # Create x and y lists based on the step directions.
              xSeq = generateSeq x;
              ySeq = generateSeq y;
            in
            # Create a flat list of coordinate pairs (like [x1, y1, x2, y2, ...]).
            builtins.concatMap (i: [
              (builtins.elemAt xSeq i)
              (builtins.elemAt ySeq i)
            ]) (builtins.genList (x: x) totalSteps);

          # Math functions
          abs = x: if x < 0 then 0 - x else x;
          mod =
            a: b:
            if b < 0 then
              0 - mod (0 - a) (0 - b)
            else if a < 0 then
              mod (b - mod (0 - a) b) b
            else
              a - b * (div a b);
          hasFraction =
            x:
            let
              splitted = lib.splitString "." (builtins.toString x);
            in
            builtins.length splitted >= 2
            &&
              builtins.length (
                builtins.filter (ch: ch != "0") (lib.stringToCharacters (builtins.elemAt splitted 1))
              ) > 0;
          multiply = builtins.foldl' builtins.mul 1;
          div =
            a: b:
            let
              divideExactly = !(hasFraction (1.0 * a / b));
              offset = if divideExactly then 0 else (0 - 1);
            in
            if b < 0 then
              offset - div a (0 - b)
            else if a < 0 then
              offset - div (0 - a) b
            else
              builtins.floor (1.0 * a / b);
          pow = x: times: multiply (lib.replicate times x);
          epsilon = pow (0.1) 10;
          round =
            x:
            let
              floorValue = builtins.floor x;
            in
            if x - floorValue >= 0.5 then floorValue + 1 else floorValue;

          # Sine and cosine function
          pi = 3.14159265358979323846264338327950288;
          sin =
            x:
            let
              x' = mod (1.0 * x) (2 * pi);
              step = i: (pow (0 - 1) (i - 1)) * multiply (lib.genList (j: x' / (j + 1)) (i * 2 - 1));
              helper =
                tmp: i:
                let
                  value = step i;
                in
                if (abs value) < epsilon then tmp else helper (tmp + value) (i + 1);
            in
            if x < 0 then -sin (0 - x) else helper 0 1;
          cos = x: sin (0.5 * pi - x);

          # Function to generate a circular arc shape
          arcShape =
            start: distance:
            let
              steps = 20; # Number of points to calculate
              path = builtins.genList (
                i:
                let
                  # Calculate the angle incrementally
                  angle = 2 * pi * (start + distance * i / (steps - 1));
                in
                [
                  (round (500 + 500 * cos angle))
                  (round (500 + 500 * sin angle))
                ]
              ) steps;
            in
            builtins.concatLists path;
        in
        [
          {
            comment = "New tab, right mouse + line down";
            event = {
              button = "Right";
              event_type = "Shape";
              shapes_xy = [
                (straightLineShape 0 1)
              ];
            };
            cmd_str = "ydotool key 29:1 20:1 20:0 29:0";
          }
          {
            comment = "Launch anyrun, right mouse + line up";
            event = {
              button = "Right";
              event_type = "Shape";
              shapes_xy = [
                (straightLineShape 0 (-1))
              ];
            };
            cmd_str = "anyrun";
          }
          {
            comment = "Next tab, right mouse + scroll";
            event = {
              button = "Right";
              event_type = "Click";
            };
            cmd_str = "ydotool key 29:1 15:1 15:0 29:0";
          }
          {
            comment = "Previous tab, right mouse + scroll";
            event = {
              button = "Right";
              event_type = "Click";
            };
            cmd_str = "ydotool key 29:1 42:1 15:1 15:0 42:0 29:0";
          }
          {
            comment = "Close tab, right mouse + draw c";
            event = {
              button = "Right";
              event_type = "Shape";
              shapes_xy = [
                (arcShape (-0.25) (-0.5))
              ];
            };
            cmd_str = "ydotool key 29:1 17:1 17:0 29:0";
          }
          {
            comment = "Reopen tab, right mouse + draw reverse c";
            event = {
              button = "Right";
              event_type = "Shape";
              shapes_xy = [
                (arcShape 0.25 0.5)
              ];
            };
            cmd_str = "ydotool key 29:1 42:1 20:1 20:0 42:0 29:0";
          }
          {
            comment = "Focus column left, right mouse + line left";
            event = {
              button = "Right";
              event_type = "Shape";
              shapes_xy = [
                (straightLineShape (-1) 0)
              ];
            };
            cmd_str = "niri msg action focus-column-left";
          }
          {
            comment = "Focus column right, right mouse + line right";
            event = {
              button = "Right";
              event_type = "Shape";
              shapes_xy = [
                (straightLineShape 1 0)
              ];
            };
            cmd_str = "niri msg action focus-column-right";
          }
          {
            comment = "Move column left, middle mouse + line left";
            event = {
              button = "Middle";
              event_type = "Shape";
              shapes_xy = [
                (straightLineShape (-1) 0)
              ];
            };
            cmd_str = "niri msg action move-column-left";
          }
          {
            comment = "Move column right, middle mouse + line right";
            event = {
              button = "Middle";
              event_type = "Shape";
              shapes_xy = [
                (straightLineShape 1 0)
              ];
            };
            cmd_str = "niri msg action move-column-right";
          }
          {
            comment = "Move column to workspace up, middle mouse + line up";
            event = {
              button = "Middle";
              event_type = "Shape";
              shapes_xy = [
                (straightLineShape 0 (-1))
              ];
            };
            cmd_str = "niri msg action move-column-to-workspace-up";
          }
          {
            comment = "Move column to workspace down, middle mouse + line down";
            event = {
              button = "Middle";
              event_type = "Shape";
              shapes_xy = [
                (straightLineShape 0 1)
              ];
            };
            cmd_str = "niri msg action move-column-to-workspace-down";
          }
        ];
    };
  };
}
