{ pkgs, ... }:

{
  imports = [
    ./poe.nix
    ./mount.nix
    ./steam.nix
    ./nvidia.nix
    ./android.nix
  ];

  programs.gamescope.enable = true;

  environment.systemPackages = with pkgs; [
    lutris
    wine-wayland
  ];
}
# vim:et:sw=2:ts=2:sta:nu
