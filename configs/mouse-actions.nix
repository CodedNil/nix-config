{
  pkgs,
  ...
}:

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
      bindings =
        let
          # Function to generate a list of coordinate pairs based on x and y
          # If x is 1 then it does 0..1000, if x is -1 it will be 1000..0, and same for y, 0 will be 0..0
          straightLineShape =
            { x, y }:
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
                else
                  # Generate list from 0 -> 1000
                  builtins.genList (i: i * stepValue) totalSteps;
              # Create x and y lists based on the step directions.
              xSeq = generateSeq x;
              ySeq = generateSeq y;
            in
            # Create a flat list of coordinate pairs (like [x1, y1, x2, y2, ...]).
            builtins.concatMap (i: [
              (builtins.elemAt xSeq i)
              (builtins.elemAt ySeq i)
            ]) (builtins.genList (x: x) totalSteps);
        in
        [
          # New tab
          {
            comment = "New tab";
            event = {
              button = "Right";
              modifiers = [ ];
              event_type = "Shape";
              shapes_xy = [
                (straightLineShape {
                  x = 0;
                  y = 1;
                })
              ];
            };
            cmd_str = "ydotool key ctrl+t";
          }
        ];
    };
  };
}
