{ pkgs, ... }:

{
  imports = [
    ./env.nix
    ./binds.nix
    ./configuration.nix
    ./rofi.nix
    ./waybar.nix
    ./hyprlock.nix
  ];

  home.packages = with pkgs; [
    libnotify
    hyprpicker
    # Screenshot
    grim
    slurp
    swappy
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    systemd.enable = true;
  };

  services.mako = {
    enable = true;
  };
}
# vim:et:sw=2:ts=2:sta:nu
