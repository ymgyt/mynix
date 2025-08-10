{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dprint
  ];

  xdg.configFile.".dprint.jsonc".source = ./dprint.jsonc;
}
