{ pkgs, ... }:

{
  # hardware.pulseaudio.enable = true;
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber = {
      configPackages = [
        (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/10-bluez.conf" ''
           monitor.bluez.properties = {
             bluez5.enable-sbc-xq = true
             bluez5.enable-msbc = true
             bluez5.enable-hw-volume = true
             bluez5.roles = [ a2dp_sink a2dp_source bap_sink bap_source hsp_hs hsp_ag hfp_hf hfp_ag ]
             bluez5.codecs = [ sbc sbc_xq aac ]
             bluez5.hfphsp-backend = "native"
          }
        '')
      ];
    };
  };

}
# vim:et:sw=2:ts=2:sta:nu
