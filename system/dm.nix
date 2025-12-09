{
  inputs,
  lib,
  pkgs,
  config,
  settings,
  ...
}:

{
  # programs.uwsm.enable = true;
  programs.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    exportConfiguration = true;
    excludePackages = [ pkgs.xterm ];
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
  services.displayManager.sddm = {
    enable = false;
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

  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtgraphicaleffects
    catppuccin-cursors.mochaDark
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
}
# vim:et:sw=2:ts=2:sta:nu
