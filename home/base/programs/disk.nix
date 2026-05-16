{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dust
  ];
}
