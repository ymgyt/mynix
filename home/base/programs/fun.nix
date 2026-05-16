{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ponysay
  ];
}
