# Configure nixos specific options
{ pkgs, ... }: {
  fonts = {
    enableDefaultFonts = true;
    # Make sure font match with alacritty font settings
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" "Noto Color Emoji" ];
      sansSerif = [ "Noto Sans CJK JP" "Noto Sans" "Noto Color Emoji" ];
      monospace = [ "Noto Sans Mono" "Noto Color Emoji" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
