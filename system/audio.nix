{ pkgs, ... }:

{
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    # Enable PulseAudio compatibility layer
    pulse.enable = true;
    wireplumber.enable = true;
    # Make sure PipeWire handles audio
    audio.enable = true;
  };

  # Disable PulseAudio server if using PipeWire's PulseAudio layer
  services.pulseaudio.enable = false;
}
# vim:et:sw=2:ts=2:sta:nu
