{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs_26
    typescript-language-server
    prettier
  ];
}
