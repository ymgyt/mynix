{ pkgs, ... }:
{
  home.packages = with pkgs; [
    meli
    swaks
  ];
  xdg.configFile."meli/config.toml".source = ./meli/config.toml;
}
