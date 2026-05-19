{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs_20
    typescript-language-server
    prettier
  ];
}
