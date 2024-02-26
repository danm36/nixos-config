{
  description = "NixOS flake for danm36";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
    
      nixosConfigurations.default = lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [ 
            ./configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };

    };
}
