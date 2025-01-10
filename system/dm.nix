{
  lib,
  pkgs,
  config,
  settings,
  ...
}:

{
  programs.uwsm.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.exportConfiguration = true;
  services.xserver.excludePackages = [ pkgs.xterm ];

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    wayland.enable = true;
    sugarCandyNix = {
      enable = true;
      settings = {
        AccentColor = "#${config.stylix.base16Scheme.base0B}";
        Background = lib.cleanSource settings.lockscreen;
        FormPosition = "left";
        HaveFormBackground = true;
        PartialBlur = true;
        ScreenWidth = 2560;
        ScreenHeight = 1440;
        RoundCorners = 5;
      };
    };
    settings = {
      Theme = {
        CursorTheme = "catppuccin-mocha-dark-cursors";
        CursorSize = 30;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtgraphicaleffects
    catppuccin-cursors.mochaDark
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.plasma5Packages.xdg-desktop-portal-kde ];
}
# vim:et:sw=2:ts=2:sta:nu
