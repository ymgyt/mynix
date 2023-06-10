# Configure nixos specific options
{ pkgs, ... }: {
  fonts = {
    enableDefaultFonts = false;
    fontconfig = {
      serif = [ "Noto Serif" "Noto Color Emoji" ];
      sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
      monospace = [ "JetBrainsMono Nerd Font" "Noto Color Emoji" ];
      emoji = [ "Noto Color Emoji" ]
        };
    };
  }
