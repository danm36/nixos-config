{ config, lib, pkgs, systemSettings, userSettings, ... }:

{
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
        "waybar"
      ];
      monitor = [
        "eDP-1,1920x1080,0x0,1"
      ];
      input = {
        kb_layout = systemSettings.keyboardLayout;
        natural_scroll = true;
      };
      bind = [
        "SUPER, RETURN, exec, kitty"
        "SUPER, A, exec, code"
        "SUPER, S, exec, firefox"
        ", Print, exec, grimblast copy area"
        "ALT,TAB,cyclenext"
        "ALT,TAB,bringactivetotop"
        "ALTSHIFT,TAB,cyclenext,prev"
        "ALTSHIFT,TAB,bringactivetotop"
        "SUPER,Q,killactive"
        "SUPERSHIFT,Q,exit"
        "SUPER,T,togglefloating"
        "SUPERCTRL,right,workspace,+1"
        "SUPERCTRL,left,workspace,-1"
        "SUPER,left,movefocus,l"
        "SUPER,up,movefocus,u"
        "SUPER,right,movefocus,r"
        "SUPER,down,movefocus,d"
        "SUPERSHIFT,left,movewindow,l"
        "SUPERSHIFT,up,movewindow,u"
        "SUPERSHIFT,right,movewindow,r"
        "SUPERSHIFT,down,movewindow,d"
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
        "SUPER,mouse:273,resizewindow"
      ];
      decoration = {
         rounding = 8;
         blur = {
           enabled = true;
           size = 5;
           passes = 2;
           ignore_opacity = true;
           contrast = 1.17;
           brightness = 0.8;
         };
       };
    };
  };

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 35;
        margin = "7 7 3 7";
        spacing = 2;

        modules-left = [ "custom/os" "custom/hyprprofile" "battery" "backlight" "pulseaudio" "network" "cpu" "memory" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "idle_inhibitor" "tray" "clock" ];

        "custom/os" = {
          "format" = " {} ";
          "exec" = ''echo "" '';
          "interval" = "once";
        };
        "custom/hyprprofile" = {
          "format" = "   {}";
          "exec" = ''cat ~/.hyprprofile'';
          "interval" = 3;
          "on-click" = "hyprprofile-dmenu";
        };
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "format-icons" = {
            "1" = "󱚌";
            "2" = "󰖟";
            "3" = "";
            "4" = "󰎄";
            "5" = "󰋩";
            "6" = "";
            "7" = "󰄖";
            "8" = "󰑴";
            "9" = "󱎓";
            "scratch_term" = "_";
            "scratch_ranger" = "_󰴉";
            "scratch_musikcube" = "_";
            "scratch_btm" = "_";
            "scratch_geary" = "_";
            "scratch_pavucontrol" = "_󰍰";
          };
          "on-click" = "activate";
          "on-scroll-up" = "hyprctl dispatch workspace e+1";
          "on-scroll-down" = "hyprctl dispatch workspace e-1";
          #"all-outputs" = true;
          #"active-only" = true;
          "ignore-workspaces" = ["scratch" "-"];
          #"show-special" = false;
          #"persistent-workspaces" = {
          #    # this block doesn't seem to work for whatever reason
          #    "eDP-1" = [1 2 3 4 5 6 7 8 9];
          #    "DP-1" = [1 2 3 4 5 6 7 8 9];
          #    "HDMI-A-1" = [1 2 3 4 5 6 7 8 9];
          #    "1" = ["eDP-1" "DP-1" "HDMI-A-1"];
          #    "2" = ["eDP-1" "DP-1" "HDMI-A-1"];
          #    "3" = ["eDP-1" "DP-1" "HDMI-A-1"];
          #    "4" = ["eDP-1" "DP-1" "HDMI-A-1"];
          #    "5" = ["eDP-1" "DP-1" "HDMI-A-1"];
          #    "6" = ["eDP-1" "DP-1" "HDMI-A-1"];
          #    "7" = ["eDP-1" "DP-1" "HDMI-A-1"];
          #    "8" = ["eDP-1" "DP-1" "HDMI-A-1"];
          #    "9" = ["eDP-1" "DP-1" "HDMI-A-1"];
          #};
        };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
        };
        tray = {
          #"icon-size" = 21;
          "spacing" = 10;
        };
        clock = {
          "interval" = 1;
          "format" = "{:%a %Y-%m-%d %I:%M:%S %p}";
          "timezone" = "America/Chicago";
          "tooltip-format" = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };
        cpu = {
          "format" = "{usage}% ";
        };
        memory = { "format" = "{}% "; };
        backlight = {
          "format" = "{percent}% {icon}";
          "format-icons" = [ "" "" "" "" "" "" "" "" "" ];
        };
        battery = {
          "states" = {
            "good" = 95;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon}";
          "format-charging" = "{capacity}% ";
          "format-plugged" = "{capacity}% ";
          #"format-good" = ""; # An empty format will hide the module
          #"format-full" = "";
          "format-icons" = [ "" "" "" "" "" ];
        };
        pulseaudio = {
          "scroll-step" = 1;
          "format" = "{volume}% {icon}  {format_source}";
          "format-bluetooth" = "{volume}% {icon}  {format_source}";
          "format-bluetooth-muted" = "󰸈 {icon}  {format_source}";
          "format-muted" = "󰸈 {format_source}";
          "format-source" = "{volume}% ";
          "format-source-muted" = " ";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [ "" "" "" ];
          };
          "on-click" = "pypr toggle pavucontrol && hyprctl dispatch bringactivetotop";
        };
      };
    };
    style = ''
      * {
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: FontAwesome, ''+userSettings.fonts.monospace.name+'';

          font-size: 20px;
      }

      window#waybar {
          background-color: #'' + config.lib.stylix.colors.base00 + '';
          opacity: 0.75;
          border-radius: 8px;
          color: #'' + config.lib.stylix.colors.base07 + '';
          transition-property: background-color;
          transition-duration: .2s;
      }

      window > box {
          border-radius: 8px;
          opacity: 0.94;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      button {
          border: none;
      }

      #custom-hyprprofile {
          color: #'' + config.lib.stylix.colors.base0D + '';
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      button:hover {
          background: inherit;
      }

      #workspaces button {
          padding: 0 7px;
          background-color: transparent;
          color: #'' + config.lib.stylix.colors.base04 + '';
      }

      #workspaces button:hover {
          color: #'' + config.lib.stylix.colors.base07 + '';
      }

      #workspaces button.active {
          color: #'' + config.lib.stylix.colors.base08 + '';
      }

      #workspaces button.focused {
          color: #'' + config.lib.stylix.colors.base0A + '';
      }

      #workspaces button.visible {
          color: #'' + config.lib.stylix.colors.base05 + '';
      }

      #workspaces button.urgent {
          color: #'' + config.lib.stylix.colors.base09 + '';
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #wireplumber,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #mpd {
          padding: 0 10px;
          color: #'' + config.lib.stylix.colors.base07 + '';
          border: none;
          border-radius: 8px;
      }

      #window,
      #workspaces {
          margin: 0 4px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0;
      }

      #clock {
          color: #'' + config.lib.stylix.colors.base0D + '';
      }

      #battery {
          color: #'' + config.lib.stylix.colors.base0B + '';
      }

      #battery.charging, #battery.plugged {
          color: #'' + config.lib.stylix.colors.base0C + '';
      }

      @keyframes blink {
          to {
              background-color: #'' + config.lib.stylix.colors.base07 + '';
              color: #'' + config.lib.stylix.colors.base00 + '';
          }
      }

      #battery.critical:not(.charging) {
          background-color: #'' + config.lib.stylix.colors.base08 + '';
          color: #'' + config.lib.stylix.colors.base07 + '';
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      label:focus {
          background-color: #'' + config.lib.stylix.colors.base00 + '';
      }

      #cpu {
          color: #'' + config.lib.stylix.colors.base0D + '';
      }

      #memory {
          color: #'' + config.lib.stylix.colors.base0E + '';
      }

      #disk {
          color: #'' + config.lib.stylix.colors.base0F + '';
      }

      #backlight {
          color: #'' + config.lib.stylix.colors.base0A + '';
      }

      #pulseaudio {
          color: #'' + config.lib.stylix.colors.base0C + '';
      }

      #pulseaudio.muted {
          color: #'' + config.lib.stylix.colors.base04 + '';
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
      }

      #idle_inhibitor {
          color: #'' + config.lib.stylix.colors.base04 + '';
      }

      #idle_inhibitor.activated {
          color: #'' + config.lib.stylix.colors.base0F + '';
      }
      '';
  };

  home.packages = with pkgs; [
    networkmanager
  ];
}