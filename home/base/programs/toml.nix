{ pkgs, ... }:
{
  home.packages = with pkgs; [
    taplo
  ];
}
