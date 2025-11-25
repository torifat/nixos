{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"

      "tag +poe, title:(Path of Exile 2)"
      "tag +poe, class:(steam_app_2694490)"
      "fullscreen, tag:poe"

      # "tag +apt, title:(Awakened PoE Trade)"
      "tag +apt, class:(Exiled-exchange-2)"
      "float, tag:apt"
      "noblur, tag:apt"
      "nofocus, tag:apt" # Disable auto-focus"
      "noshadow, tag:apt"
      "noborder, tag:apt"
      "pin, tag:apt"
      "renderunfocused, tag:apt"
      "size 100% 100%, tag:apt"
      "center, tag:apt"

      "workspace 2, class:(steam)"
    ];
  };
}
# vim:et:sw=2:ts=2:sta:nu
