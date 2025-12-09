{ pkgs, ... }:

{
  # covers both poe1 and poe2
  environment.systemPackages = with pkgs; [
    awakened-poe-trade
    exiled-exchange-2
    rusty-path-of-building
  ];
}
# vim:et:sw=2:ts=2:sta:nu
