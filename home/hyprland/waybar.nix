{ config, ... }:

{
  stylix.targets.waybar.enable = false;
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
      * {
        font-family: "Monaspace Xeon";
      }

      #waybar {
        background: transparent;
      }

      #waybar.hidden {
        opacity: 0.2;
      }

      box.horizontal {
      }

      box.module {}

      .modules-left .module {
        margin-right: 10px;
      }

      .modules-right .module {
        margin-left: 10px;
      }

      label.module {
        border-radius: 10px;
        padding: 0 10px;
        color: #${config.stylix.base16Scheme.base00};
        background: #${config.stylix.base16Scheme.base05};
      }

      #tray {
        border-radius: 10px;
        padding: 0 10px;
        background: #${config.stylix.base16Scheme.base00};
      }

      #bluetooth {
        background: #${config.stylix.base16Scheme.base0D};
      }

      #pulseaudio {
        background: #${config.stylix.base16Scheme.base0A};
      }

      #custom-power {
        background: #${config.stylix.base16Scheme.base08};
      }

      #clock {
        background: #${config.stylix.base16Scheme.base0B};
      }
    '';
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 24;

        modules-left = [
          "hyprland/window"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "tray"
          "gamemode"
          "bluetooth"
          "network"
          "pulseaudio"
          "clock"
          "custom/power"
        ];

        # "hyprland/workspaces" = {
        #   "format" = "<sub>{icon}</sub>\n{windows}";
        #   "format-window-separator" = "\n";
        #   "window-rewrite-default" = "";
        #   "window-rewrite" = {
        #     "title<.*youtube.*>" = "";
        #     "class<firefox>" = "";
        #     "class<firefox> title<.*github.*>" = "";
        #     "foot" = "";
        #     "code" = "󰨞";
        #   };
        # };

        tray = {
          icon-size = 16;
          spacing = 10;
        };

        "custom/launcher" = {
          format = "";
          on-click = "rofi -show drun";
          on-click-right = "killall rofi";
        };

        bluetooth = {
          tooltip = false;
          on-click = "blueman-manager";
          format = "{icon}";
          format-icons = {
            default = [
              ""
              ""
            ];
          };
        };

        pulseaudio = {
          tooltip = false;
          scroll-step = 5;
          format = "{icon} {volume}%";
          format-muted = "{icon} {volume}%";
          # TODO: Make this conditional based on if pulseaudio or pipewire is running
          # on-click = "pactl set-sink.mute @DEFAULT_SINK@ toggle";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          format-icons = {
            default = [
              ""
              ""
              ""
            ];
          };
        };

        clock = {
          format = " {:%H:%M}";
          format-alt = " {:%b %d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "custom/power" = {
          format = "";
          # format = "";
          on-click = "rofi -show powermenu";
          on-click-right = "killall rofi";
        };
      };
    };
  };
}
# vim:et:sw=2:ts=2:sta:nu
