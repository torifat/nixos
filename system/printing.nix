{ pkgs, ... }:

{
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    # Canon PIXMA TS3400
    drivers = [ pkgs.cnijfilter2 ];
  };

  # Enable SANE to scan documents.
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };
  services.udev.packages = [ pkgs.sane-airscan ];

  # Enable autodiscovery of network printers.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
# vim:et:sw=2:ts=2:sta:nu
