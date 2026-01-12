{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    plugins = with pkgs; [
      rofi-calc
      rofi-systemd
      rofi-power-menu
    ];
  };
}
# vim:et:sw=2:ts=2:sta:nu
