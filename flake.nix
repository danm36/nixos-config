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

     stylix = {
        url = "github:danth/stylix";
     };
  };

  outputs = { 
    self, nixpkgs, home-manager, nixos-hardware,
    stylix, plasma-manager, ... 
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
      windowManager = "plasma5"; # A folder in ~/window-managers.
      theme = "neutron"; # A folder in ~/themes
      fonts = rec {
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };
        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };
        monospace = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans Mono";
        };
        emoji = {
          package = pkgs.noto-fonts-emoji-blob-bin;
          name = "Noto Color Emoji";
        };
        sizes = {
          terminal = 10;
          applications = 10;
          popups = 10;
          desktop = 10;
        };
      };

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
          inputs.home-manager.nixosModules.default
          stylix.nixosModules.stylix
          ./hosts/alphavm.nix
        ];
      };

      # My laptop
      epsilon = lib.nixosSystem {
        system = systemSettings.system;
        specialArgs = {
          inherit inputs;
          inherit systemSettings;
          inherit userSettings;
          inherit (inputs) stylix;
        };
        modules = [
          home-manager.nixosModules.default
          nixos-hardware.nixosModules.lenovo-ideapad-z510
          ./hosts/epsilon.nix
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
          inherit (inputs) stylix;
        };
      };
    };
  };
}
