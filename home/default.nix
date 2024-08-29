{ pkgs, settings, ... }:

{
  imports = [
    ./hyprland
    ./modules
    ./neovim
    ./shell.nix
    ./git.nix
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
      # Misc
      bluetuith
      unzip
      entr
      minesweep-rs
      ncdu
      # Todo app
      dooit
      # Markdown reader
      glow
    ];
    shellAliases = {
      g = "git";
      gp = "git push";
      n = "nix";
      v = "vim";
      lst = "ls --tree";
    };
    stateVersion = "24.05";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  services.network-manager-applet.enable = true;

  programs.ripgrep.enable = true;
  programs.firefox.enable = true;
  programs.fastfetch.enable = true;

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      # Quickly search through and highlight files using ripgrep.
      batgrep
      # Read system manual pages (man) using bat as the manual page formatter.
      batman
      # A less (and soon bat) preprocessor for viewing more types of files in the terminal.
      batpipe
      # Watch for changes in one or more files, and print them with bat.
      batwatch
      # Diff a file against the current git index, or display the diff between two files.
      # batdiff
      # Pretty-print source code and highlight it with bat.
      prettybat
    ];
  };

  programs.lsd = {
    enable = true;
    enableAliases = true;
    settings = {
      date = "relative";
      ignore-globs = [ ".git" ];
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.home-manager.enable = true;
}
# vim:et:sw=2:ts=2:sta:nu
