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

  networking.hostName = "dan-work"; # Define your hostname.
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };
}