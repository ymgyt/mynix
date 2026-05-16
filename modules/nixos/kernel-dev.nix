{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.kernel-dev;
  kernelPkg = config.boot.kernelPackages;
  kernel = kernelPkg.kernel;
in
{
  options.my.kernel-dev.enable = lib.mkEnableOption "kernel development tooling (perf, kernel sources, mm-tools)";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gcc
      linuxHeaders
      perf
      kernel.dev
      kernelPkg.mm-tools
    ];

    environment.variables = {
      __LINUX_HEADER = "${pkgs.linuxHeaders}/include";
      __KDIR = "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build";
    };
  };
}
