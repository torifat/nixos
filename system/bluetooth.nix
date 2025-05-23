{ ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;
}
# vim:et:sw=2:ts=2:sta:nu
