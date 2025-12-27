{ pkgs, ... }:
{
  services = {
    # enable COSMIC
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
}
