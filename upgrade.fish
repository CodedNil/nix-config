#!/usr/bin/env fish

# Define paths
set log_file (pwd)/nix-upgrade.log
set pre_upgrade_file (mktemp)
set post_upgrade_file (mktemp)

# Function to capture current package versions
function capture_packages
    nix-store --query --requisites /run/current-system |
    xargs nix-store --query --deriver |
    xargs nix-instantiate --eval --expr 'with import <nixpkgs> {}; builtins.elemAt (builtins.parseDrvName (builtins.baseNameOf <derivation>))' --strict --json |
    jq -r '.[] | [.name, (.version // "?")] | @tsv'
end

# Capture pre-upgrade state
capture_packages > $pre_upgrade_file

# Run Nix flake update and rebuild
nix flake update
nixos-rebuild switch --flake .#

# Capture post-upgrade state
capture_packages > $post_upgrade_file

# Log upgrades
echo "Upgrades on "(date) "\n" >> $log_file
diff --new-line-format="%L" --old-line-format="%L → " --unchanged-line-format="" $pre_upgrade_file $post_upgrade_file >> $log_file
echo "--------------------------------------" >> $log_file

# Clean up temporary files
rm $pre_upgrade_file
rm $post_upgrade_file