{ pkgs, ... }:

{
  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];
  users.defaultUserShell = pkgs.zsh;
}
# vim:et:sw=2:ts=2:sta:nu
