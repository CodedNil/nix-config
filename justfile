default:
  sudo nixos-rebuild switch --flake '.#dan-nixos'

update:
  git add .
  nix flake update
u: update

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
