{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    niri.url = "github:sodiboo/niri-flake";
    anyrun.url = "github:anyrun-org/anyrun";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nixcord.url = "github:kaylorben/nixcord";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      niri,
      anyrun,
      spicetify-nix,
      nixcord,
      zen-browser,
    }@inputs:
    {
      nixosConfigurations =
        let
          system = "x86_64-linux";
          makeSystem =
            specificModule:
            nixpkgs.lib.nixosSystem {
              system = system;
              specialArgs = { inherit inputs; };
              modules = [
                home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;

                  home-manager.sharedModules = [
                    nixcord.homeManagerModules.nixcord
                    spicetify-nix.homeManagerModules.default
                  ];
                }

                niri.nixosModules.niri
                { nixpkgs.overlays = [ niri.overlays.niri ]; }

                ./common.nix
                ./compositor.nix
                ./shell.nix
                specificModule
              ];
            };
        in
        {
          dan-pc = makeSystem ./pc.nix;
          dan-work = makeSystem ./work.nix;
        };
    };
}
