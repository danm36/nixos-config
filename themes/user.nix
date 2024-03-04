{ lib, pkgs, stylix, userSettings, ... }:

{
  stylix.image = pkgs.fetchurl {
    url = "https://www.pixelstalk.net/wp-content/uploads/images6/Outer-Space-Desktop-Background.jpg";
    sha256 = "C54smeYgPZpt6a3Aye6qm89uhDSq0YHnFuVKR2nmGi0=";
  };
  stylix.polarity = "dark";

  stylix.fonts = userSettings.fonts;
}
