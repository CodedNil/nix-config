{
  pkgs,
  ...
}:

{
  home-manager.users.dan = {
    # Fish and compatible programs
    programs.fish = {
      enable = true;
      interactiveShellInit = "set fish_greeting";
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
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
    };
    programs.eza = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  programs.fish.enable = true;
  environment.systemPackages = with pkgs; [
    nerd-fonts.fira-code
    font-awesome
    noto-fonts-emoji

    just
    bottom
    tokei
    wl-clipboard

    cryfs
    sshfs

    bat
    fd
  ];
}
