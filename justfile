default:
  sudo nixos-rebuild switch --flake '.#'

edit:
  nano configuration.nix

editf:
  nano flake.nix

flake:
  sudo nix flake update
