{ pkgs, ... }:

{
  programs.awakened-poe-trade.enable = true;

  programs.mangohud = {
    enable = true;
    settings = {
      offset_x = 1800;
    };
  };
}
# vim:et:sw=2:ts=2:sta:nu
