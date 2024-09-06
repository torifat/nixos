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
    libsForQt5.polkit-kde-agent
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
      package = pkgs.rose-pine-gtk-theme;
      name = "rose-pine";
    };

    iconTheme = {
      package = pkgs.rose-pine-icon-theme;
      name = "rose-pine";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    systemd.enable = true;
  };

  systemd.user.services.polkit-kde-auth-agent = {
    Unit = {
      Description = "PolKit KDE Auth Service";
      PartOf = [ "graphical-session.target" ];
      Requires = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
      BusName = "org.kde.polkit-kde-authentication-agent-1";
      Slice = "background.slice";
      TimeoutSec = "5sec";
      Restart = "on-failure";
    };

    Install = {
      WantedBy = [ "hyprland-session.target" ];
    };
  };

  services.mako = {
    enable = true;
  };
}
# vim:et:sw=2:ts=2:sta:nu
