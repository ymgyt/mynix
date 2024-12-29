# Configure common options in nixos and darwin
{ pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;

    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji

      # nerdfotns
      # https://www.nerdfonts.com/font-downloads
      # items are inferred from the actual downloaded file name
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };
}
