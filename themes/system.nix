{ lib, pkgs, stylix, userSettings, ... }:

{
  # Default style on the system.
  imports = [ stylix.nixosModules.stylix ];

  stylix.image = pkgs.fetchurl {
    url = "https://www.pixelstalk.net/wp-content/uploads/images6/Outer-Space-Desktop-Background.jpg";
    sha256 = "C54smeYgPZpt6a3Aye6qm89uhDSq0YHnFuVKR2nmGi0=";
  };
  stylix.polarity = "dark";

  stylix.fonts = userSettings.fonts;

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ userSettings.fonts.serif.name ];
      sansSerif = [ userSettings.fonts.sansSerif.name ];
      monospace = [ userSettings.fonts.monospace.name ];
    };
  };
}
