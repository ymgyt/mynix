{ ... }: {
  programs.helix = {
    # Currently use my fork
    enable = false;
  };
  xdg.configFile."helix/config.toml".source = ./config.toml;
  xdg.configFile."helix/languages.toml".source = ./languages.toml;
}
