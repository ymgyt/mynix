{ pkgs, ... }:
{
  home.packages = with pkgs; [
    perlnavigator
  ];
}
