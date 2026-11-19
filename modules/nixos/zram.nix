{ lib, config, ... }:
let
  cfg = config.my.zram;
in
{
  options.my.zram.enable = lib.mkEnableOption "compressed swap in RAM (zram)";

  config = lib.mkIf cfg.enable {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 50;
    };

    boot.kernel.sysctl = {
      "vm.swappiness" = 180;
      "vm.page-cluster" = 0;
    };
  };
}
