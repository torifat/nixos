{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    bindm = [ "$mod, mouse:272, movewindow" ];

    bind = [
      "$mod, Q, killactive,"
      "$mod SHIFT, T, exec, ghostty"
      "$mod, DELETE, exit,"
      "$mod SHIFT, R, exec, hyprctl reload"
      "$mod, ESC, exec, hyprlock"

      # Screenshots
      "ALT SHIFT, 4, exec, grim -g \"$(slurp)\" - | wl-copy"
      "ALT SHIFT, 3, exec, grim - | wl-copy"

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

      # Special workspace (scratchpad)
      "$mod, S, togglespecialworkspace, magic"
      "$mod SHIFT, S, movetoworkspace, special:magic"

      "$mod SHIFT, SPACE, exec, hyprctl switchxkblayout current next"
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
