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

    programs.starship.enable = true; # RUST: Shell prompt
    programs.zoxide.enable = true; # RUST: Directory jumper
    programs.atuin.enable = true; # RUST: Shell history manager
  };

  programs.fish.enable = true;
  environment.systemPackages = with pkgs; [
    nerd-fonts.fira-code
    font-awesome
    noto-fonts-emoji

    # Development Tools
    just # RUST: Command runner
    bottom # RUST: Terminal process monitor
    tokei # RUST: Code statistics tool
    wl-clipboard # C: Wayland clipboard utilities

    # Shell Enhancements
    eza # RUST: Modern 'ls' replacement
    yazi # RUST: Terminal file manager
    bat # RUST: 'cat' clone with syntax highlighting
    fd # RUST: Simple, fast 'find' alternative

    # Filesystem Tools
    cryfs # C++: Encrypted filesystem
    sshfs # C: Filesystem client based on SSH
  ];
}
