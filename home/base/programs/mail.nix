{ pkgs, ... }:
{
  home.packages = with pkgs; [
    swaks
  ];
}
