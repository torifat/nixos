{ pkgs, ... }:

{
  programs = {
    adb.enable = true;
    kdeconnect.enable = true;
  };

  networking.firewall = rec {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

  environment.systemPackages = with pkgs; [
    localsend
  ];
}
# vim:et:sw=2:ts=2:sta:nu
