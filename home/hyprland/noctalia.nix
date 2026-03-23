{ pkgs, lib, ... }:

{
  programs.noctalia-shell = {
    enable = true;
    settings = {
      location = {
        name = "Revesby, NSW, Australia";
      };
      settings = {
        dock.enabled = false;
      };
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
      };
    };

    layerrule = [
      "blur true, match:namespace ^noctalia"
      "ignore_alpha 0.5, match:namespace ^noctalia"
      "blur_popups true, match:namespace ^noctalia"
    ];
  };
}
