{ pkgs, ... }:

{
  # The modern way to enable GPU passthrough for containers
  hardware.nvidia-container-toolkit.enable = true;

  virtualisation.docker = {
    enable = true;
    # IMPORTANT: Despite the warning, this is often still needed
    # for the '--gpus all' flag to work in Docker on NixOS.
    enableNvidia = true;
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers."tdarr-node" = {
      image = "haveagitgat/tdarr_node:latest";
      autoStart = true;

      extraOptions = [
        "--network=host"
        "--gpus=all" # This uses the toolkit enabled above
      ];

      environment = {
        PUID = "2000";
        PGID = "2000";
        TZ = "Australia/Sydney";
        nodeID = "lovelace-docker";
        nodeIP = "0.0.0.0";
        serverURL = "https://tdarr-server.rifat.homes";
        serverPort = "8266";
        NVIDIA_VISIBLE_DEVICES = "all";
        NVIDIA_DRIVER_CAPABILITIES = "all";
      };

      volumes = [
        "/mnt/media:/media"
        "/mnt/media/cache/transcode:/media/cache/transcode"
      ];
    };
  };
}
