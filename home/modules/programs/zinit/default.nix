{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.programs.zinit;
  zsh = config.programs.zsh.enable;
in
{
  options = {
    programs.zinit.enable = lib.mkEnableOption "zinit";
  };

  config = lib.mkIf (cfg.enable && zsh) {

    xdg.dataFile = {
      "zinit/zinit-core".source = pkgs.fetchFromGitHub {
        owner = "zdharma-continuum";
        repo = "zinit";
        rev = "main";
        sha256 = "sha256-ppwIyljIehEomhd3xxb+Xdwss3qQY1pB30Fqj2+YAaA=";
      };
    };

    home.file.p10k = {
      target = ".p10k.zsh";
      source = ./p10k.zsh;
    };

    # TODO: Add config options for the theme & plugins
    programs.zsh.initContent = lib.mkOrder 550 ''
      # Enable Powerlevel10k instant prompt.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      # Install zinit
      source "''${XDG_DATA_HOME:-''${HOME}/.local/share}/zinit/zinit-core/zinit.zsh"

      # Setup Theme
      zi ice filter=blob:none
      zi light romkatv/powerlevel10k

      # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


      # Autosuggestions & fast-syntax-highlighting
      # -----------------------------------------------------------------------
      zi wait lucid for \
         atinit'
            ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay;
            zstyle ":history-search-multi-word" page-size "11";
         ' \
            z-shell/F-Sy-H \
         blockf \
            zsh-users/zsh-completions \
         atload'!_zsh_autosuggest_start' \
            zsh-users/zsh-autosuggestions \
            z-shell/H-S-MW \
         atload'
            bindkey "^[[A" history-substring-search-up;
            bindkey "^[[B" history-substring-search-down;
         ' \
              zsh-users/zsh-history-substring-search
    '';
  };
}
# vim:et:sw=2:ts=2:sta:nu
