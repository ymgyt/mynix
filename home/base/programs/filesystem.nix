{ pkgs, ... }: {
  programs.exa = {
    enable = true;
    enableAliases = true;
    icons = true;
  };

  home.packages = with pkgs; [
    yazi
  ];
}
