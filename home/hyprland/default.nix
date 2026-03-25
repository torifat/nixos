{ pkgs, ... }:

{
  imports = [
    ./env.nix
    ./binds.nix
    ./configuration.nix
    ./noctalia.nix
    ./windowrules.nix
    ./hyprlock.nix
  ];

  home.packages = with pkgs; [
    libnotify
    hyprpicker
    # Screenshot
    grim
    slurp
    swappy
    # Clipboard
    wl-clipboard
  ];

  stylix.targets.gtk.enable = false;
  gtk = {
    enable = true;

    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.vivid-plasma-themes;
      name = "vivid-glassy-dark-icon-theme";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    systemd.enable = true;
  };

}
# vim:et:sw=2:ts=2:sta:nu
