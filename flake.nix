{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs.follows = "nixos-cosmic/nixpkgs";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";

    niri.url = "github:sodiboo/niri-flake";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-cosmic,
      niri,
      spicetify-nix,
      zen-browser,
    }@inputs:
    {
      nixosConfigurations =
        let
          makeSystem =
            specificModule:
            nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              specialArgs = { inherit inputs; };
              modules = [
                home-manager.nixosModules.home-manager

                niri.nixosModules.niri
                { nixpkgs.overlays = [ niri.overlays.niri ]; }

                nixos-cosmic.nixosModules.default
                {
                  nix.settings = {
                    substituters = [ "https://cosmic.cachix.org/" ];
                    trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
                  };
                }

                spicetify-nix.nixosModules.default

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
