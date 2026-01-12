{ pkgs, settings, ... }:

{
  imports = [
    ./hyprland
    ./modules
    ./neovim
    ./shell.nix
    ./git.nix
    ./misc.nix
    ./mobile.nix
  ];

  home = {
    username = settings.username;
    packages = with pkgs; [
      pulsemixer
      pavucontrol
      obsidian
      # waybar dependency
      # wayland optimized Discord client
      vesktop
      # Todo app
      dooit
      # Markdown reader
      glow
      # File manager
      thunar
      # PDF Reader
      zathura
      kdePackages.okular
      # YubiKey app
      yubioath-flutter
      # Misc
      bluetuith
      unzip
      entr
      minesweep-rs
      ncdu
      google-chrome
      zellij
      tmux
      prusa-slicer
      nmap
      simple-scan
    ];
    stateVersion = "25.05";
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
  stylix.targets.firefox.profileNames = [ "default" ];

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.home-manager.enable = true;
}
# vim:et:sw=2:ts=2:sta:nu
