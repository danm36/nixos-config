{ lib, pkgs, config, stylix, userSettings, ... }:

{
  stylix.autoEnable = false;
  stylix.image = pkgs.fetchurl {
    url = "https://www.pixelstalk.net/wp-content/uploads/images6/Outer-Space-Desktop-Background.jpg";
    sha256 = "C54smeYgPZpt6a3Aye6qm89uhDSq0YHnFuVKR2nmGi0=";
  };
  stylix.polarity = "dark";

  stylix.fonts = userSettings.fonts;

  stylix.targets = {
    firefox.enable = true;
    gtk.enable = true;
    kitty.enable = true;
    rofi.enable = true;
  };

  home.file.".config/.swaybg-stylix" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      swaybg -m fill -i '' + config.stylix.image + '';
      '';
  };
}
