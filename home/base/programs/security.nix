{ pkgs, ... }:
{
  home.packages = with pkgs; [
    rage
    trivy
  ];
}
