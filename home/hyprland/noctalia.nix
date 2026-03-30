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
      general = {
        radiusRatio = 0.35;
        iRadiusRatio = 0.35;
      };
      location = {
        name = "Revesby, NSW, Australia";
      };
      dock.enabled = false;
      bar = {
        barType = "framed";
        widgets = {
          left = [
            { id = "Clock"; }
            {
              id = "SystemMonitor";
              showLoadAverage = true;
              showNetworkStats = true;
            }
          ];
          center = [
            {
              id = "Workspace";
              emptyColor = "error";
              focusedColor = "tertiary";
              laebelMode = "name";
              opcupiedColor = "none";
              showLabelsOnlyWhenOccupied = false;
            }
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
            { id = "Network"; }
            {
              id = "Bluetooth";
              displayMode = "alwaysHide";
            }
            { id = "Volume"; }
            { id = "Brightness"; }
            { id = "KeepAwake"; }
            { id = "NotificationHistory"; }
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
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
      allow_tearing = false;
    };

    decoration = {
      rounding = 10;
      rounding_power = 2;

      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
        color = lib.mkForce "rgba(1a1a1aee)";
      };

      blur = {
        enabled = true;
        size = 6;
        passes = 3;
        # vibrancy = 0.1696;
        # ignore_opacity = true;
        # popups = true;
      };

    };

    layerrule = [
      "match:namespace noctalia-background-.*$, blur on"
      "match:namespace noctalia-background-.*$, ignore_alpha 0.5"
      "match:namespace noctalia-background-.*$, blur_popups on"
    ];
  };
}
