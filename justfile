default:
  nh os switch . --hostname="dan-pc" --update

work:
  sudo nixos-rebuild switch --flake '.#dan-work'
w: work

update:
  git add .
  nix flake update
u: update

clean:
  nix-env --delete-generations old
  sudo nix-collect-garbage -d
  sudo nix-store --optimise
c: clean