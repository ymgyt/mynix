{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dive
  ];
}
