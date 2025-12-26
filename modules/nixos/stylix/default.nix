{ pkgs, ... }:
let
  # https://tinted-theming.github.io/tinted-gallery/
  theme = "gruvbox-material-dark-soft";
in
{
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";

    image = ./wallpaper.jpg;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 25;
    };
  };
}
