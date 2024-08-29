{ ... }:

{
  fonts = {
    # Whether to create a directory with links to all fonts in /run/current-system/sw/share/X11/fonts.
    fontDir.enable = true;
    # Enable a basic set of fonts providing several styles and families and reasonable coverage of Unicode.
    enableDefaultPackages = true;
  };
}
# vim:et:sw=2:ts=2:sta:nu
