{ pkgs-unstable, ... }:
{
  programs.nushell = {
    enable = true;
    package = pkgs-unstable.nushell;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
  };

  xdg.configFile."nushell/autoload/01-aliases.nu".source = ./autoload/01-aliases.nu;
  xdg.configFile."nushell/autoload/02-commands.nu".source = ./autoload/02-commands.nu;
  xdg.configFile."nushell/starship/init.nu".source = ./starship/init.nu;

  programs.starship = {
    enable = true;
    enableNushellIntegration = false;
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  xdg.configFile."starship.toml".source = ./starship/starship.toml;

  home.packages = with pkgs-unstable; [
    nufmt
  ];
}
