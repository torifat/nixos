{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    # e -> repeat, will repeat when held.
    # l -> locked, will also work when an input inhibitor (e.g. a lockscreen) is active.
    bindel = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86MonBrightnessUp, exec, ddcutil -d 1 setvcp 10 + 5"
      ", XF86MonBrightnessDown, exec, ddcutil -d 1 setvcp 10 - 5"
    ];

    bindl = [ ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" ];

    bind = [
      "$mod, Q, killactive,"
      "$mod, R, exec, rofi -show drun -show-icons"
      "$mod SHIFT, T, exec, ghostty"
      "$mod, DELETE, exit,"
      "$mod, ESC, exec, hyprlock"

      # Move window focus with vim keys
      "$mod, H, movefocus, l"
      "$mod, L, movefocus, r"
      "$mod, K, movefocus, u"
      "$mod, J, movefocus, d"

      # Toggle windows with vim keys
      "$mod SHIFT, H, movewindow, l"
      "$mod SHIFT, L, movewindow, r"
      "$mod SHIFT, K, movewindow, u"
      "$mod SHIFT, J, movewindow, d"

      # Switch workspaces.
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"

      "$mod CTRL, H, workspace, r-1"
      "$mod CTRL, L, workspace, r+1"

      # Move active window to a workspace.
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"
      "$mod CTRL SHIFT, L, movetoworkspace, r+1"
      "$mod CTRL SHIFT, H, movetoworkspace, r-1"

      # Example special workspace (scratchpad)
      "$mod, S, togglespecialworkspace, magic"
      "$mod SHIFT, S, movetoworkspace, special:magic"
    ];
  };
}
# vim:et:sw=2:ts=2:sta:nu
