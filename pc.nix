{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix # Include the results of the hardware scan.
  ];

  networking.hostName = "dan-pc";
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Load Nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false; # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.finegrained = false; # Fine-grained power management. Turns off GPU when not in use.
    open = true; # Use the NVidia open source kernel module
    nvidiaSettings = true; # Enable the Nvidia settings menu, accessible via `nvidia-settings`.
    package = config.boot.kernelPackages.nvidiaPackages.stable; # Optionally, you may need to select the appropriate driver version for your specific GPU.
  };

  # Vault drive mount
  fileSystems."/mnt/vault" = {
    device = "/dev/disk/by-uuid/8a4efbd6-f7c4-4baf-ae29-df8f5835e127";
    fsType = "btrfs";
  };

  home-manager.users.dan.programs.fish.functions = {
    enc = ''
        cryfs /mnt/vault/Enc /mnt/vault/EncMnt --blocksize 131072
    '';
    encu = ''
        rm -rf ~/.cache/thumbnails
        rm -rf ~/.local/share/Trash/files
        rm -f ~/.bash_history
        rm -f ~/.local/share/fish/fish_history
        wl-copy --clear
        atuin search --delete-it-all
        cryfs-unmount /mnt/vault/EncMnt
    '';
    };
}
