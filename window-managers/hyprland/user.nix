{ config, lib, pkgs, systemSettings, userSettings, ... }:

{
  imports = [
    ./apps/swaylock.nix
    ./apps/waybar.nix
    ./apps/dunst.nix
    ./apps/thunar.nix
  ];
  
  home.packages = with pkgs; [
    swaybg
    swayosd
  ];

  gtk.cursorTheme = {
    package = pkgs.quintom-cursor-theme;
    name = if (config.stylix.polarity == "light") then "Quintom_Ink" else "Quintom_Snow";
    size = 24;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [ ];
    settings = {
      exec-once = [
        "dbus-update-activation-environment DISPLAY XAUTHORITY WAYLAND_DISPLAY"
        ("hyprctl setcursor " + config.gtk.cursorTheme.name + " " + builtins.toString config.gtk.cursorTheme.size)
        "kwalletd5"
        "polkit-kde-authentication-agent-1"
        "nm-applet"
        "blueman-applet"
        "swayosd-server"
        "discord --start-minimized"

        "hyprctl dispatch exec [workspace 1 silent] kitty"
        "hyprctl dispatch exec [workspace 2 silent] firefox"
      ];
      exec = [
        "~/.config/.swaybg-stylix"
      ];
      monitor = [
        "eDP-1,1920x1080,0x0,1"
        ",preferred,auto,1"
      ];
      input = {
        kb_layout = systemSettings.keyboardLayout;
        touchpad = {
          disable_while_typing = true;
          natural_scroll = true;
          scroll_factor = 0.4;
        };
      };
      general = {
        border_size = 4;
        gaps_in = 4;
        gaps_out = 8;
      };
      windowrule = [
        "float,^(discord)$"
      ];
      bind = [
        "SUPER, RETURN, exec, kitty"
        "SUPER, A, exec, code"
        "SUPER, S, exec, firefox"
        "SUPER, R, exec, rofi -show drun"
        "SUPER, F, exec, thunar"

        ", Print, exec, grimblast copy area"

        "ALT, TAB, cyclenext"
        "ALT, TAB, bringactivetotop"
        "ALTSHIFT, TAB, cyclenext, prev"
        "ALTSHIFT, TAB, bringactivetotop"
        "SUPER, Q, killactive"
        "SUPERSHIFT, Q, exit"
        "SUPER, T, togglefloating"
        "SUPERCTRL, right, workspace, +1"
        "SUPERCTRL, left, workspace, -1"
        "SUPERALT, right, movetoworkspace, +1"
        "SUPERALT, left, movetoworkspace, -1"
        "SUPER, left, movefocus, l"
        "SUPER, up, movefocus, u"
        "SUPER, right, movefocus, r"
        "SUPER, down, movefocus, d"
        "SUPERSHIFT, left, movewindow, l"
        "SUPERSHIFT, up, movewindow, u"
        "SUPERSHIFT, right, movewindow, r"
        "SUPERSHIFT, down, movewindow, d"

        ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
        ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
        ", XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
        ", XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
        ", XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "SUPER, ${ws}, workspace, ${toString (x + 1)}"
              "SUPER SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
      bindm = [
        "SUPER,mouse:272,movewindow"
        #"SUPER,mouse:273,resizewindow"
        "SUPERCTRL,mouse:272,resizewindow"
      ];
      gestures = {
        workspace_swipe = true;
      };
      decoration = {
        rounding = 8;
        inactive_opacity = 0.8;
        dim_inactive = true;
        dim_strength = 0.1;
         blur = {
          enabled = true;
          size = 5;
          passes = 2;
          ignore_opacity = true;
          contrast = 1.17;
          brightness = 0.8;
        };
      };
      animations = {
        enabled = true;
        bezier = [
          "bounce, 0.05, 0.9, 0.1, 1.05"
        ];
        animation = [
          "windows, 1, 3, bounce"
          "workspaces, 1, 4, bounce, slidefade"
        ];
      };
    };
    extraConfig = ''
      general {
        col.active_border = 0xff'' + config.lib.stylix.colors.base01 + ''

        col.inactive_border = 0x33'' + config.lib.stylix.colors.base00 + ''

      }
      '';
  };
}