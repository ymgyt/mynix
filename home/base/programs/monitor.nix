{ pkgs, ... }:
{
  home.packages = with pkgs; [
    procs
    bottom
    fastfetch
  ];
}
