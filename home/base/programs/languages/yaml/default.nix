{ pkgs, ... }:
{
  home.packages = with pkgs; [
    yaml-language-server
    yamlfmt
  ];

  xdg.configFile."yamlfmt/yamlfmt.yaml".source = ./yamlfmt.yaml;
}
