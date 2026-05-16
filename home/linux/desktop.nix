{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libnotify
    wl-clipboard-rs
    wiremix
  ];
}
