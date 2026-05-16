{ pkgs, ... }:
{
  programs.bat.enable = true;
  programs.eza.enable = true;

  home.packages = with pkgs; [
    file
    hexyl
    w3m
  ];
}
