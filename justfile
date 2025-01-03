default:
  sudo nixos-rebuild switch --flake '.#'

edit:
  nano configuration.nix

editf:
  nano flake.nix

flake:
  sudo nix flake update

clean:
  sudo nix-env --delete-generations old
  sudo nix-collect-garbage
  nix-store --optimise