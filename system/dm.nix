{
  inputs,
  lib,
  pkgs,
  config,
  settings,
  ...
}:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  services.displayManager.ly.enable = true;

  xdg.portal.enable = true;
}
# vim:et:sw=2:ts=2:sta:nu
