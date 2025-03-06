{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs_20
    volta
    nodePackages_latest.typescript-language-server
    nodePackages_latest.prettier
  ];
}
