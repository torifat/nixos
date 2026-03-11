{ pkgs, ... }:

{
  # users.users.nfs-worker = {
  #   isSystemUser = true;
  #   uid = 2000;
  #   group = "nfs-worker";
  # };
  # users.groups.nfs-worker.gid = 2000;

  environment.systemPackages = with pkgs; [
    nfs-utils
    nvtopPackages.nvidia
  ];

  fileSystems."/mnt/media" = {
    device = "10.20.30.51:/mnt/rust/Media/media";
    fsType = "nfs";
    options = [
      "rw"
      "nfsvers=4.2"
      "noatime"
      "nodiratime"
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600"
    ];
  };
  boot.supportedFilesystems = [ "nfs" ];
}
# vim:et:sw=2:ts=2:sta:nu
