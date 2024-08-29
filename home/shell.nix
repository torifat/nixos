{ ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      update = "sudo nixos-rebuild switch --flake ~/.config/nixos";
    };
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
