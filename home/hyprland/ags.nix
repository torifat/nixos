{ inputs, pkgs, ... }:

{
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  programs.ags = {
    enable = true;
    # No configDir — ArchEclipse needs a writable ~/.config/ags for cache/settings.
    # Copy manually: cp -r /path/to/nixos/home/hyprland/ags ~/.config/ags

    extraPackages = with inputs.ags.packages.${pkgs.stdenv.hostPlatform.system}; [
      hyprland
      wireplumber
      tray
      apps
      battery
      mpris
      notifd
      powerprofiles
      cava
    ] ++ [
      pkgs.libadwaita
      pkgs.brightnessctl
      pkgs.sassc
      pkgs.gcc
    ];
  };
}
# vim:et:sw=2:ts=2:sta:nu
