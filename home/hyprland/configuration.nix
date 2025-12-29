{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
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

  };
}
# vim:et:sw=2:ts=2:sta:nu
