{ pkgs, ... }:

{
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
      extraConfig = {
        "51-disable-nvidia-audio" = {
          monitor.alsa.rules = [
            {
              matches = [ { "device.name" = "alsa_card.pci-0000_01_00.1"; } ];
              actions.update-props = {
                "device.disabled" = true;
              };
            }
          ];
        };
        "10-bluez" = {
          monitor.alsa.rules = [
            {
              matches = [ { "device.name" = "~bluez_card.*"; } ];
              actions.update-props = {
                "bluez5.enable-sbc-xq" = true;
                "bluez5.enable-msbc" = true;
                "bluez5.enable-hw-volume" = true;
                "bluez5.headset-roles" = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]";
              };
            }
          ];
        };
      };
    };
  };

}
# vim:et:sw=2:ts=2:sta:nu
