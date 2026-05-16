{ pkgs, ... }:
{
  home.packages = with pkgs; [
    biome
    vscode-langservers-extracted
  ];
}
