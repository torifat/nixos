{ lib, ... }:

{
  qt = {
    enable = true;
    platformTheme = lib.mkForce "qt5ct";
    # style = "adwaita";
  };
}
# vim:et:sw=2:ts=2:sta:nu
