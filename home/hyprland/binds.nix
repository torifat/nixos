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

    bind =
      [
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

        "$mod CTRL, H, workspace, r-1"
        "$mod CTRL, L, workspace, r+1"
        "$mod CTRL SHIFT, L, movetoworkspace, r+1"
        "$mod CTRL SHIFT, H, movetoworkspace, r-1"

        # Example special workspace (scratchpad)
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"
      ]
      ++ (
        # Workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
            in
            [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          ) 9
        )
      );
  };
}
# vim:et:sw=2:ts=2:sta:nu
