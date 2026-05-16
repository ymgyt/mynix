{ pkgs, ... }:
{
  home.packages = with pkgs; [
    usbutils
    pciutils
    kbt
  ];
}
