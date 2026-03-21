{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # Picture-in-Picture
      "float on, match:title ^(Picture-in-Picture)$"
      "pin on, match:title ^(Picture-in-Picture)$"

      # Path of Exile 1
      "tag +poe1, match:class steam_app_238960"
      "workspace 4, match:tag poe1"
      "immediate on, match:tag poe1"
      "no_blur on, match:tag poe1"
      "no_shadow on, match:tag poe1"
      "border_size 0, match:tag poe1"

      # Path of Exile 2
      "tag +poe2, match:class steam_app_2694490"
      "workspace 4, match:tag poe2"
      "immediate on, match:tag poe2"
      "no_blur on, match:tag poe2"
      "no_shadow on, match:tag poe2"
      "border_size 0, match:tag poe2"

      # Exiled Exchange 2 overlay
      "tag +ee2, match:class ^(exiled-exchange-2)$"
      "float on, match:tag ee2"
      "no_blur on, match:tag ee2"
      "no_anim on, match:tag ee2"
      "no_shadow on, match:tag ee2"
      "border_size 0, match:tag ee2"
      "no_follow_mouse on, match:tag ee2"

      # Steam client
      "workspace 3, match:class steam"
    ];
  };
}
# vim:et:sw=2:ts=2:sta:nu
