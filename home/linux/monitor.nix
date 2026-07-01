{ pkgs, ... }:
{
  home.packages = with pkgs; [
    iotop
    sysstat
  ];
}
