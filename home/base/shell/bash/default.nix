{ pkgs, ... }: {
  home.packages = with pkgs; [
    nodePackages_latest.bash-language-server
  ];
}
