{ pkgs, settings, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = settings.name;
        email = settings.email;
      };
      alias = {
        s = "status";
        sw = "switch";
        ci = "commit";
        co = "checkout";
      };
    };
  };

  home.packages = with pkgs; [
    pre-commit
    git-secrets
  ];
}
# vim:et:sw=2:ts=2:sta:nu
