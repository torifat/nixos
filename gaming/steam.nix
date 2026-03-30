{ pkgs, settings, ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    # package = pkgs.millennium-steam;
    package = pkgs.millennium-steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          gamescope
        ];
    };
  };

  users.users.${settings.username}.extraGroups = [
    "gamemode"
  ];

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
        softrealtime = "auto";
        inhibit_screensaver = 0;
      };
      custom = {
        start = "${pkgs.docker}/bin/docker stop tdarr-node && caelestia shell gameMode enable";
        end = "${pkgs.docker}/bin/docker start tdarr-node && caelestia shell gameMode disable";
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        nv_powermizer_mode = 1;
      };
    };
  };

}
# vim:et:sw=2:ts=2:sta:nu
