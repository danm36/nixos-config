{ pkgs, systemSettings, userSettings, ... }:

{
  fonts.packages = with pkgs; [
    # Fonts
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    powerline
    fira-code-nerdfont
    iosevka
    font-awesome
    ubuntu_font_family
    terminus_font
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ userSettings.fonts.serif.name ];
      sansSerif = [ userSettings.fonts.sansSerif.name ];
      monospace = [ userSettings.fonts.monospace.name ];
    };
  };
}
