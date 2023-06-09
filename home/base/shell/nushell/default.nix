{ ... }: {
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
  };

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
  };

  # generate by `starship preset nerd-font-symbols -o ./starship.toml`
  xdg.configFile."starship.toml".source = ./starship.toml;
}