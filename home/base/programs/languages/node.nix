{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs_20
    volta
    typescript-language-server
    prettier
  ];
}
