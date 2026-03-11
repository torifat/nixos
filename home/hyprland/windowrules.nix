{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "tag +poe, title:(Path of Exile)"
      "tag +poe, class:(steam_app_238960)"
      "workspace 4, tag:poe"
      "fullscreen, tag:poe"

      # "float, title:^(Picture-in-Picture)$"
      # "pin, title:^(Picture-in-Picture)$"

      # "tag +poe, title:(Path of Exile)"
      # "tag +poe, initialTitle:(Path of Exile)"
      # "tag +poe, class:(steam_app_238960)"
      # "tag +poe, title:(Path of Exile 2)"
      # "tag +poe, initialTitle:(Path of Exile 2)"
      # "tag +poe, class:(steam_app_2694490)"
      # "workspace 5, tag:poe"
      # "fullscreen, tag:poe"

      # "tag +apt, title:(Awakened PoE Trade)"
      # "tag +apt, title:(Exiled Exchange 2)"
      # "float, tag:apt "
      # "noblur, tag:apt"
      # "noanim, tag:apt"
      # "noshadow, tag:apt"
      # "nofocus, tag:apt"
      # "noinitialfocus, tag:apt"
      # "center, tag:apt"
      # "pin, tag:apt"
      # "renderunfocused, tag:apt"
      # "size 100% 100%, tag:apt"
      # "workspace 5, tag:apt"

      # Path of Exile 2 - fullscreen game
      # "tag +poe, class:(steam_app_2694490)"
      # "tile, class:(steam_app_2694490)"
      # "fullscreen, class:(steam_app_2694490)"

      # Exiled Exchange 2 - overlay tool
      # "tag +apt, title:(exiled-exchange-2|Exiled Exchange 2)"
      # "float, tag:apt"
      # "noblur, tag:apt"
      # "nofocus, tag:apt"
      # "noshadow, tag:apt"
      # "noborder, tag:apt"
      # "pin, tag:apt"
      # "renderunfocused, tag:apt"
      # "size 100% 100%, tag:apt"
      # "move 0 0, tag:apt"
      # "stayfocused, class:(steam_app_2694490)"

      "workspace 2, class:(steam)"
    ];
  };
}
# vim:et:sw=2:ts=2:sta:nu
