{ pkgs, settings, ... }:

{
  imports = [
    ./hyprland
    ./modules
    ./neovim
    ./shell.nix
    ./git.nix
    ./misc.nix
  ];

  home = {
    username = settings.username;
    packages = with pkgs; [
      pulsemixer
      pavucontrol
      obsidian
      # waybar dependency
      font-awesome
      # wayland optimized Discord client
      vesktop
      # Todo app
      dooit
      # Markdown reader
      glow
      # File manager
      xfce.thunar
      # PDF Reader
      zathura
      okular
      # YubiKey app
      yubioath-flutter
      # Misc
      bluetuith
      unzip
      entr
      minesweep-rs
      ncdu
      google-chrome
    ];
    stateVersion = "24.05";
  };

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "okular.desktop";
      };
    };
  };

  services.network-manager-applet.enable = true;

  programs.firefox = {
    enable = true;
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.home-manager.enable = true;
}
# vim:et:sw=2:ts=2:sta:nu
