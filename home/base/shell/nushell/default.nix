{ ... }: {
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
  };
  xdg.configFile."nu/completions/cargo-completions.nu".source = ./completions/cargo-completions.nu;
  xdg.configFile."nu/completions/git-completions.nu".source = ./completions/git-completions.nu;
  xdg.configFile."nu/completions/nix-completions.nu".source = ./completions/nix-completions.nu;
  xdg.configFile."nu/completions/poetry-completions.nu".source = ./completions/poetry-completions.nu;
  xdg.configFile."nu/completions/typst-completions.nu".source = ./completions/typst-completions.nu;
  xdg.configFile."nu/completions/zellij-completions.nu".source = ./completions/zellij-completions.nu;

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
  };

  # generate by `starship preset nerd-font-symbols -o ./starship.toml`
  xdg.configFile."starship.toml".source = ./starship.toml;
}
