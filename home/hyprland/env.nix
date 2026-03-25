{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    env = [
      "XDG_CURRENT_DESKTOP,Hyprland"
      "XDG_SESSION_TYPE,wayland"
      "XDG_SESSION_DESKTOP,Hyprland"
      "QT_QPA_PLATFORM,wayland"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
      # Causing some issues after latest firefox bump
      "MOZ_ENABLE_WAYLAND,0"
      "QT_QPA_PLATFORMTHEME,qt6ct"
    ];
  };
}
# vim:et:sw=2:ts=2:sta:nu
