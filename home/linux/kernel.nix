{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libcgroup
    libcap
  ];
}
