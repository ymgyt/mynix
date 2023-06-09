{ ... }: {

  programs.zsh = {
    enable = true;
  };

  home.file.".zshrc".source = ./.zshrc;
  home.file.".zshenv".source = ./.zshenv;
}
