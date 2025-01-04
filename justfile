default:
  sudo nixos-rebuild switch --flake '.#'

update:
  sudo nix-channel --update

edit:
  nano configuration.nix

editf:
  nano flake.nix

flake:
  sudo nix flake update

clean:
  sudo nix-env --delete-generations old
  sudo nix-collect-garbage
  sudo nix-collect-garbage -d
  nix-store --optimise