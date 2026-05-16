{ pkgs, ... }:
{
  home.packages = with pkgs; [
    typos
  ];
}
