{ settings, ... }:

{
  fileSystems = {
    "/home/${settings.username}/Games" = {
      fsType = "btrfs";
      device = "dev/disk/by-id/nvme-CT2000P3SSD8_2241E67709E0-part1";
      options = [
        "compress=zstd"
        "noatime"
      ];
    };
  };
}
# vim:et:sw=2:ts=2:sta:nu
