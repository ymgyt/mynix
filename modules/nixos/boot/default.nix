{ pkgs, ... }:
{
  imports = [
    ./btf.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  # boot.kernelPackages = pkgs.linuxPackages_6_18;
  boot.kernelPackages = pkgs.linuxPackages_7_0;
}
