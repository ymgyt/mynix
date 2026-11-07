{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.cosmic;
in
{
  options.my.cosmic.enable = lib.mkEnableOption "COSMIC desktop with cosmic-greeter and system76-scheduler";

  config = lib.mkIf cfg.enable {
    services = {
      displayManager.cosmic-greeter.enable = true;
      desktopManager.cosmic = {
        enable = true;
        showExcludedPkgsWarning = true;
        xwayland.enable = true;
      };

      system76-scheduler.enable = true;
    };

    environment.cosmic.excludePackages = with pkgs; [
      cosmic-edit
    ];
  };
}
