{ pkgs, ... }:
{
  home.packages = with pkgs; [
    graphviz
    dot-language-server
  ];
}
