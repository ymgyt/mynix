{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gdb
  ];
}
