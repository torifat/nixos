{ ... }:

{
  imports = [
    ./boot.nix
    ./dm.nix
    ./qt.nix
    ./fonts.nix
    ./bluetooth.nix
    ./shell.nix
    ./utils.nix
  ];

  # Auto mount/unmount drive
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
# vim:et:sw=2:ts=2:sta:nu
