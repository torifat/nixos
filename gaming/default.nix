{ pkgs, ... }:

{
  imports = [
    ./mount.nix
    ./steam.nix
    ./nvidia.nix
    ./android.nix
  ];

  programs.gamescope.enable = true;
}
# vim:et:sw=2:ts=2:sta:nu
