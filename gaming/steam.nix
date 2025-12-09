{ pkgs, settings, ... }:

{
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    package = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          gamescope
        ];
    };
  };

  users.users.${settings.username}.extraGroups = [
    "gamemode"
  ];

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [ mangohud ];
}
# vim:et:sw=2:ts=2:sta:nu
