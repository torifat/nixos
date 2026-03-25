{ pkgs, lib, ... }:
{
  programs.noctalia-shell = {
    enable = true;
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        polkit-agent = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 2;
    };
    settings = {
      settingsVersion = 59;
      location = {
        name = "Revesby, NSW, Australia";
      };
      dock.enabled = false;
      bar = {
        widgets = {
          left = [
            {
              id = "Launcher";
              useDistroLogo = true;
            }
            { id = "Clock"; }
          ];
          right = [
            {
              id = "Tray";
              drawerEnabled = false;
              colorizeIcons = true;
              blacklist = [
                # Wifi
                "nm-applet"
                # Input method
                "Fcitx"
                # Mouse software
                "indicator-solaar"
              ];
            }
            {
              id = "Bluetooth";
              displayMode = "alwaysHide";
            }
            { id = "Network"; }
            { id = "Volume"; }
            { id = "Brightness"; }
            { id = "KeepAwake"; }
            { id = "NotificationHistory"; }
            { id = "ControlCenter"; }
          ];
        };
      };
      appLauncher = {
        enableClipboardHistory = true;
        termiinalComamnd = "ghostty -e";
        overviewLayer = true;
      };
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        lock_cmd = "noctalia-shell ipc call lockScreen lock";
      };

      listener = [
        {
          timeout = 900;
          on-timeout = "noctalia-shell ipc call lockScreen lock";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 21600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  wayland.windowManager.hyprland.settings = {
    "$ipc" = "noctalia-shell ipc call";

    exec-once = [ "noctalia-shell" ];

    bind = [
      "$mod, SPACE, exec, $ipc launcher toggle"
      "$mod, V, exec, $ipc launcher clipboard"
      "$mod, S, exec, $ipc controlCenter toggle"
      "$mod, comma, exec, $ipc settings toggle"
    ];

    bindel = [
      ", XF86AudioRaiseVolume, exec, $ipc volume increase"
      ", XF86AudioLowerVolume, exec, $ipc volume decrease"
      ", XF86MonBrightnessUp, exec, $ipc brightness increase"
      ", XF86MonBrightnessDown, exec, $ipc brightness decrease"
    ];

    bindl = [
      ", XF86AudioMute, exec, $ipc volume muteOutput"
    ];
    general = {
      gaps_in = 5;
      gaps_out = 10;
    };

    decoration = {
      rounding = 20;
      rounding_power = 2;

      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
        color = lib.mkForce "rgba(1a1a1aee)";
      };

      blur = {
        enabled = true;
        size = 3;
        passes = 2;
        vibrancy = 0.1696;
        ignore_opacity = true;
        popups = true;
      };
    };

    layerrule = [
      "blur on, match:namespace ^noctalia"
      "blur_popups on, match:namespace ^noctalia"
      "ignore_alpha 0.3, match:namespace ^noctalia"
      "xray on, match:namespace ^noctalia"
    ];
  };
}
