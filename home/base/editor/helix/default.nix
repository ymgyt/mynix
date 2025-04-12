{ myhelix, ... }:
{
  programs.helix = {
    # Currently use my fork
    enable = false;
  };
  home.packages = [ myhelix ];
  xdg.configFile."helix/config.toml".source = ./config.toml;
  xdg.configFile."helix/languages.toml".source = ./languages.toml;
  xdg.configFile."helix/ignore".source = ./ignore;
}
