{
  description = "DM's Flake";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { 
    self, nixpkgs, home-manager, nixos-hardware,
    plasma-manager, blender-bin, ... 
  }@inputs:
  let
    systemSettings = {
      system = "x86_64-linux";
      timezone = "Europe/London";
      locale = "en_GB.UTF-8";
      keyMap = "uk";
      keyboardLayout = "gb";
      keyboardVariant = "";
    };

    userSettings = rec {
      username = "dmasterson";
      name = "Daniel";
      windowManager = "plasma5";

      # Obfuscated to avoid spam bots
      email = _email_1 + _email_5 + _email_3 + _email_2 + _email_4 + _email_6;
      _email_1 = "dmas";
      _email_2 = "nova" + "dawn";
      _email_3 = "son@";
      _email_4 = "studios.c";
      _email_5 = "ter";
      _email_6 = "o.uk";
    };

    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${systemSettings.system};
  in {
    nixosConfigurations = {

      # The test VM
      alphavm = lib.nixosSystem {
        system = systemSettings.system;
        specialArgs = {
          inherit inputs;
          inherit systemSettings;
          inherit userSettings;
        };
        modules = [
          ./hosts/alphavm.nix
          inputs.home-manager.nixosModules.default
        ];
      };

      # My laptop
      epsilon = lib.nixosSystem {
        system = systemSettings.system;
        specialArgs = {
          inherit inputs;
          inherit systemSettings;
          inherit userSettings;
        };
        modules = [
          ./hosts/epsilon.nix
          home-manager.nixosModules.default
          nixos-hardware.nixosModules.lenovo-ideapad-z510
        ];
      };
    };
    homeConfigurations = {
      dmasterson = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          plasma-manager.homeManagerModules.plasma-manager
          ./home/home.nix
          ({
            nixpkgs.overlays = [
              #blender-bin.overlays.default
            ];
          })
        ];
        extraSpecialArgs = {
          inherit inputs;
          inherit systemSettings;
          inherit userSettings;
        };
      };
    };
  };
}
