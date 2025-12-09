{ config, pkgs, ... }:

{
  stylix.targets.waybar.enable = false;
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
      * {
        font-family: "Monaspace Xenon, Symbols Nerd Font";
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
          "custom/mouse-toggle"
          "bluetooth"
          "network"
          "pulseaudio"
          "clock"
          "custom/power"
        ];

        "hyprland/workspaces" = {
          all-outputs = false;
          active-only = "false";
          # on-scroll-up = "${getExe' config.wayland.windowManager.hyprland.package "hyprctl"} dispatch workspace e+1";
          # on-scroll-down = "${getExe' config.wayland.windowManager.hyprland.package "hyprctl"} dispatch workspace e-1";
          format = "{icon} {windows}";
          format-icons = {
            "1" = "󰎤";
            "2" = "󰎧";
            "3" = "󰎪";
            "4" = "󰎭";
            "5" = "󰎱";
            "6" = "󰎳";
            "7" = "󰎶";
            "8" = "󰎹";
            "9" = "󰎼";
            "10" = "󰽽";
            "urgent" = "󱨇";
            "default" = "";
            "empty" = "󱓼";
          };
          # "format-window-separator" = "->";
          window-rewrite-default = "";
          window-rewrite = {
            "class<.blueman-manager-wrapped>" = "";
            "class<.devede_ng.py-wrapped>" = "";
            "class<.pitivi-wrapped>" = "󱄢";
            "class<.xemu-wrapped>" = "";
            "class<1Password>" = "󰢁";
            "class<Alacritty>" = "";
            "class<Ardour-.*>" = "";
            "class<Bitwarden>" = "󰞀";
            "class<Caprine>" = "󰈎";
            "class<DBeaver>" = "";
            "class<Element>" = "󰭹";
            "class<Darktable>" = "󰄄";
            "class<Github Desktop>" = "󰊤";
            "class<Godot>" = "";
            "class<Mysql-workbench-bin>" = "";
            "class<Nestopia>" = "";
            "class<Postman>" = "󰛮";
            "class<Ryujinx>" = "󰟡";
            "class<Slack>" = "󰒱";
            "class<Spotify>" = "";
            "class<Youtube Music>" = "";
            "class<bleachbit>" = "";
            "class<code>" = "󰨞";
            "class<com.obsproject.Studio" = "󱜠";
            "class<com.usebottles.bottles>" = "󰡔";
            "class<discord>" = "󰙯";
            "class<dropbox>" = "";
            "class<dupeGuru>" = "";
            "class<firefox.*> title<.*github.*>" = "";
            "class<firefox.*> title<.*twitch|youtube|plex|tntdrama|bally sports.*>" = "";
            "class<firefox.*>" = "";
            "class<foot>" = "";
            "class<fr.handbrake.ghb" = "󱁆";
            "class<heroic>" = "󱢾";
            "class<info.cemu.Cemu>" = "󰜭";
            "class<io.github.celluloid_player.Celluloid>" = "";
            "class<kitty>" = "";
            "class<libreoffice-calc>" = "󱎏";
            "class<libreoffice-draw>" = "󰽉";
            "class<libreoffice-impress>" = "󱎐";
            "class<libreoffice-writer>" = "";
            "class<mGBA>" = "󱎓";
            "class<mediainfo-gui>" = "󱂷";
            "class<melonDS>" = "󱁇";
            "class<minecraft-launcher>" = "󰍳";
            "class<mpv>" = "";
            "class<org.gnome.Nautilus>" = "󰉋";
            "class<org.kde.digikam>" = "󰄄";
            "class<org.kde.filelight>" = "";
            "class<org.prismlauncher.PrismLauncher>" = "󰍳";
            "class<org.qt-project.qtcreator>" = "";
            "class<org.shotcut.Shotcut>" = "󰈰";
            "class<org.telegram.desktop>" = "";
            "class<org.wezfurlong.wezterm>" = "";
            "class<pavucontrol>" = "";
            "class<pcsx2-qt>" = "";
            "class<pcsxr>" = "";
            "class<shotwell>" = "";
            "class<steam>" = "";
            "class<tageditor>" = "󱩺";
            "class<teams-for-linux>" = "󰊻";
            "class<thunar>" = "󰉋";
            "class<thunderbird>" = "";
            "class<unityhub>" = "󰚯";
            "class<virt-manager>" = "󰢹";
            "class<looking-glass-client>" = "󱇽";
            "class<vlc>" = "󱍼";
            "class<wlroots> title<.*WL-1.*>" = "";
            "class<xwaylandvideobridge>" = "";
            "code-url-handler" = "󰨞";
            "title<RPCS3.*>" = "";
            "title<Spotify Free>" = "";
            "title<Steam>" = "";
          };
        };

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

        "custom/mouse-toggle" = {
          format = "{}";
          interval = 1;
          exec = pkgs.writeShellScript "gamemode-status" ''
            HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
            if [ "$HYPRGAMEMODE" = 1 ] ; then
              echo "🎮"
            else
              echo "🎮"
            fi
          '';
          on-click = pkgs.writeShellScript "toggle-gamemode" ''
            HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
            if [ "$HYPRGAMEMODE" = 1 ] ; then
                hyprctl --batch "\
                    keyword animations:enabled 0;\
                    keyword animation borderangle,0; \
                    keyword decoration:shadow:enabled 0;\
                    keyword decoration:blur:enabled 0;\
                    keyword decoration:fullscreen_opacity 1;\
                    keyword general:gaps_in 0;\
                    keyword general:gaps_out 0;\
                    keyword general:border_size 1;\
                    keyword decoration:rounding 0;\
                    keyword input:touchpad:disable_while_typing 0"
                hyprctl notify 1 5000 "rgb(40a02b)" "Gamemode [ON]"
                exit
            else
                hyprctl notify 1 5000 "rgb(d20f39)" "Gamemode [OFF]"
                hyprctl reload
                exit 0
            fi
            exit 1
          '';
          tooltip = "Toggle gamemode (animations + mouse lock)";
        };
      };
    };
  };
}
# vim:et:sw=2:ts=2:sta:nu
