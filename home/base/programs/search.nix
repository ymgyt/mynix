{ pkgs, ... }:
{
  programs.fd.enable = true;

  home.packages = with pkgs; [
    ripgrep
    fzf
  ];
}
