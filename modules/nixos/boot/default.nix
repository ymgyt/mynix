{ pkgs, ... }:
{
  imports = [
    ./debug_info_btf.nix
  ];

  boot.loader.grub.configurationLimit = 10;

  boot.kernelPackages = pkgs.linuxPackages_6_18;
}
