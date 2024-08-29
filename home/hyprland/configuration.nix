{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "firefox"
      "ghostty"
      "1password --silent"
    ];

    input = {
      kb_layout = "us";
      follow_mouse = true;
    };

    misc = {
      vrr = 1;
    };

    monitor = [ ", highres, auto, 1" ];

  };
}
# vim:et:sw=2:ts=2:sta:nu
