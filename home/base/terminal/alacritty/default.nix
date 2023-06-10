{ ... }: {
  programs.alacritty = {
    enable = true;
  };

  home.file.".alacritty.yml".source = ./alacritty.yml;
}
