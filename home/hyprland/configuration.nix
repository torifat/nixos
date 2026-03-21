{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "ags run ~/.config/ags"
      "ghostty"
      "1password --silent"
      # Input Method Daemon
      "fcitx5 -d"
      "steam -silent -no-browser"
      "google-chrome-stable --restore-last-session"
    ];

    input = {
      kb_layout = "us";
      follow_mouse = true;
    };

    misc = {
      vrr = 1;
    };

    monitor = [ ", preferred, auto, 1" ];

    cursor.no_hardware_cursors = true;
    opengl.nvidia_anti_flicker = true;

    # Gaming workspace — no gaps so tiled PoE fills the screen
    workspace = [
      "4, gapsout:0, gapsin:0, border:false, rounding:false"
    ];

  };
}
# vim:et:sw=2:ts=2:sta:nu
