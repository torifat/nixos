{ pkgs, ... }:

{
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    # Canon PIXMA TS3400
    drivers = [ pkgs.cnijfilter2 ];
  };

  # Enable autodiscovery of network printers.
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
# vim:et:sw=2:ts=2:sta:nu
