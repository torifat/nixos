{ ... }:

{
  boot.kernel.sysctl = {
    # Reduce swap usage — keep game assets in RAM
    "vm.swappiness" = 10;

    # Improve responsiveness under memory pressure
    "vm.vfs_cache_pressure" = 50;

    # BBR congestion control — lower latency for PoE network traffic
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "fq";

    # Increase network buffer sizes for burst traffic
    "net.core.rmem_max" = 16777216;
    "net.core.wmem_max" = 16777216;

    # Disable split lock mitigation — small perf gain on Zen kernel
    "kernel.split_lock_mitigate" = 0;
  };

  # Use performance CPU governor when gaming
  powerManagement.cpuFreqGovernor = "performance";
}
# vim:et:sw=2:ts=2:sta:nu
