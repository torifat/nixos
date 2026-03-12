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
    ./mouse.nix
    ./nfs.nix
    ./tdarr-node.nix
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nixfmt
    tldr
    btop
    ghostty
    nvfetcher
    niri
    jq
    tdarr-node
    claude-code
    lmstudio
  ];

  # Hibernate

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
