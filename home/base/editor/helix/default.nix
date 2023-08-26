{ ... }: {
  programs.helix = {
    # TODO: currently using master or specific branch
    enable = false;
  };
  xdg.configFile."helix/config.toml".source = ./config.toml;
}
