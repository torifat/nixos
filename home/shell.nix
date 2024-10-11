{ pkgs, ... }:

{
  home = {
    shellAliases = {
      g = "git";
      gp = "git push";
      n = "nix";
      v = "vim";
      lst = "ls --tree";
      cat = "bat";
    };
  };

  programs.ripgrep.enable = true;
  programs.fastfetch.enable = true;

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.vivid = {
    enable = true;
    enableZshIntegration = true;
    theme = "snazzy";
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

  programs.zsh = {
    enable = true;
  };

  programs.zinit.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    silent = true;
  };
}
# vim:et:sw=2:ts=2:sta:nu
