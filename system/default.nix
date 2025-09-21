{ pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./audio.nix
    ./dm.nix
    ./qt.nix
    ./fonts.nix
    ./bluetooth.nix
    ./shell.nix
    ./utils.nix
    ./wooting.nix
    ./printing.nix
    ./mobile.nix
  ];

  # Auto mount/unmount drive
  services = {
    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-m17n
        # fcitx5-openbangla-keyboard
      ];
      waylandFrontend = true;
    };
  };
}
# vim:et:sw=2:ts=2:sta:nu
