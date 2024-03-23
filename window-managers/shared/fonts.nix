{ pkgs, ... }:

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

}
