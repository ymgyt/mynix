{ pkgs, ... }:
{
  home.packages = with pkgs; [
    man-pages
    man-pages-posix
  ];
}
