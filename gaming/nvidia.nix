{ config, pkgs, ... }:

{
  # Enable OpenGL
  hardware.graphics.enable = true;
  # ddcutil requries i2c
  hardware.i2c.enable = true;

  environment = {
    systemPackages = with pkgs; [ ddcutil ];
    variables = {
      # Necessary to correctly enable va-api (video codec hardware
      # acceleration). If this isn't set, the libvdpau backend will be
      # picked, and that one doesn't work with most things, including
      # Firefox.
      LIBVA_DRIVER_NAME = "nvidia";
      # Required to run the correct GBM backend for nvidia GPUs on wayland
      GBM_BACKEND = "nvidia-drm";
      # Apparently, without this nouveau may attempt to be used instead
      # (despite it being blacklisted)
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      # Hardware cursors are currently broken on nvidia
      WLR_NO_HARDWARE_CURSORS = "1";

      # Required to use va-api it in Firefox. See
      # https://github.com/elFarto/nvidia-vaapi-driver/issues/96
      MOZ_DISABLE_RDD_SANDBOX = "1";
      # It appears that the normal rendering mode is broken on recent
      # nvidia drivers:
      # https://github.com/elFarto/nvidia-vaapi-driver/issues/213#issuecomment-1585584038
      NVD_BACKEND = "direct";
      # Required for firefox 98+, see:
      # https://github.com/elFarto/nvidia-vaapi-driver#firefox
      EGL_PLATFORM = "wayland";

      # For Electron apps
      NIXOS_OZONE_WL = "1";
    };
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = true;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  boot = {
    # Booting to Text Mode
    initrd.kernelModules = [ "nvidia" ];
    extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

    extraModprobeConfig = ''
      options nvidia NVreg_UsePageAttributeTable=1
      options nvidia NVreg_EnablePCIeGen3=1
      # This is sometimes needed for DDC/CI supprt. @see https://www.ddcutil.com/nvidia/
      options nvidia NVreg_RegistryDwords=RMUseSwI2c=0x01;RMI2cSpeed=100
    '';
  };
}
# vim:et:sw=2:ts=2:sta:nu
