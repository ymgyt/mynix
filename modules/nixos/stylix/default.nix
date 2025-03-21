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
    };

    fonts = {
      serif = {
        package = pkgs.noto-fonts-cjk-sans;
        name = "Noto Serif";
      };
      sansSerif = {
        package = pkgs.noto-fonts-cjk-sans;
        name = "Noto Sans CJK JP";
      };
      monospace = {
        package = pkgs.noto-fonts-cjk-sans;
        name = "Noto Sans Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
