{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "zen"
      "ghostty"
      "1password --silent"
      # Input Method Daemon
      "fcitx5 -d"
    ];

    input = {
      kb_layout = "us";
      follow_mouse = true;
    };

    misc = {
      vrr = 1;
    };

    monitor = [ ", preferred, auto, 1" ];

  };
}
# vim:et:sw=2:ts=2:sta:nu
