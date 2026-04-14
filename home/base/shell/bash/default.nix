{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bash-language-server
    shellcheck
  ];
}
