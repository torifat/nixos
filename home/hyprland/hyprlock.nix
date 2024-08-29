{ ... }:

{
  programs.hyprlock = {
    enable = true;
    settings = {
      path = "screenshot";
      general = {
        grace = 0;
        ignore_empty_input = true;
      };
    };
  };
}
# vim:et:sw=2:ts=2:sta:nu
