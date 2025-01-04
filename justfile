default:
  sudo nixos-rebuild switch --flake '.#'

update:
  sudo nix-channel --update
u: update

flake:
  nix flake update
f: flake

clean:
  nix-env --delete-generations old
  sudo nix-collect-garbage -d
  sudo nix-store --optimise
c: clean

edit:
  nano configuration.nix
e: edit

editf:
  nano flake.nix
ef: editf

setup:
  sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
  sudo nix-channel --update