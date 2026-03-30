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
      vrr = 2;
    };

monitor = [ "DP-1, 2560x1440@164.84, auto, 1" ];

    cursor.no_hardware_cursors = false;
    opengl.nvidia_anti_flicker = true;

  };
}
# vim:et:sw=2:ts=2:sta:nu
