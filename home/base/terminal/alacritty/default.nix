{ ... }: {
  programs.alacritty = { enable = true; };

  # yaml is deprecated
  home.file.".alacritty.yml".source = ./alacritty.yml;
  home.file.".alacritty.toml".source = ./alacritty.toml;
}
