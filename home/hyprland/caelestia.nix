{ ... }:
{
  programs.caelestia = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
      environment = [ ];
    };
    settings = {
      clock = {
        showDate = true;
        showIcon = false;
      };
      bar = {
        activeWindow = {
          compact = true;
        };
        popouts = {
          activeWindow = false;
        };
        status = {
          showBattery = false;
        };
        paths.wallpaperDir = "~/Images";
      };
    };
    cli = {
      enable = true;
      settings = {
        theme.enableGtk = false;
      };
    };
  };

  wayland.windowManager.hyprland.settings = {
    "$ipc" = "caelestia shell";

    exec-once = [ "caelestia-shell" ];

    bind = [
      "$mod, SPACE, exec, $ipc drawers toggle launcher"
      "$mod, V, exec, caelestia clipboard"
      "$mod, comma, exec, $ipc controlCenter open"
    ];

    # bindel = [
    #   ", XF86AudioRaiseVolume, exec, $ipc volume increase"
    #   ", XF86AudioLowerVolume, exec, $ipc volume decrease"
    #   ", XF86MonBrightnessUp, exec, $ipc brightness increase"
    #   ", XF86MonBrightnessDown, exec, $ipc brightness decrease"
    # ];
    #
    # bindl = [
    #   ", XF86AudioMute, exec, $ipc volume muteOutput"
    # ];
  };
}
