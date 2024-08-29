{ pkgs, ... }:

{
  # Use the systemd-boot EFI boot loader.
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot = {
        enable = true;
        # configurationLimit = 5;
        consoleMode = "auto";
      };
      timeout = 3;
      efi.canTouchEfiVariables = true;
    };
    # Silent boot
    initrd.verbose = false;
    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
    ];
    # Boot theme
    plymouth = {
      enable = true;
      #   theme = "breeze";
    };
  };
}
# vim:et:sw=2:ts=2:sta:nu
