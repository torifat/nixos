{ ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        ignore_empty_input = true;
      };
    };
  };
}
# vim:et:sw=2:ts=2:sta:nu
