## A notifications provider that uses libnotify.
{ config, lib, pkgs, systemSettings, userSettings, ... }:

{
  home.packages = with pkgs; [
    dunst
    hicolor-icon-theme
  ];

  services.dunst = {
    enable = true;
    settings = {
      global = {
        browser = "${config.programs.firefox.package}/bin/firefox -new-tab";
        corner_radius = 16;
        dmenu = "${pkgs.rofi}/bin/rofi -dmenu";
        enable_recursive_icon_lookup = true;
        follow = "mouse";
        font = userSettings.fonts.sansSerif.name;
        format = "<b>%s</b>\\n%b";
        frame_color = "#" + config.lib.stylix.colors.base07 + "ff";
        frame_width = 2;
        gap_size = 8;
        horizontal_padding = 12;
        #icon_path = "/run/current-system/sw/share/icons/hicolor:~/.nix-profile/share/icons/hicolor:${pkgs.hicolor-icon-theme}/share/icons/hicolor";
        icon_position = "left";
        icon_size = 48;
        #icon_theme = "Papirus-Dark";
        line_height = 0;
        markup = "full";
        offset = "12+30";
        origin = "top-right";
        padding = 8;
        progress_bar = true;
        width = 350;
        transparency = 10;
        word_wrap = true;
      };
      urgency_low = {
        background = "#" + config.lib.stylix.colors.base00 + "e6";
        foreground = "#" + config.lib.stylix.colors.base03 + "ff";
        frame_color = "#" + config.lib.stylix.colors.base03 + "ff";
        timeout = 5;
      };
      urgency_normal = {
        background = "#" + config.lib.stylix.colors.base00 + "e6";
        foreground = "#" + config.lib.stylix.colors.base07 + "ff";
        frame_color = "#" + config.lib.stylix.colors.base07 + "ff";
        timeout = 10;
      };
      urgency_critical = {
        background = "#" + config.lib.stylix.colors.base00 + "e6";
        foreground = "#" + config.lib.stylix.colors.base08 + "ff";
        frame_color = "#" + config.lib.stylix.colors.base08 + "ff";
        timeout = 0;
      };
    };
  };
}
