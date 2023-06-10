# Configure common options in nixos and darwin
{ pkgs, ... }: {
  fonts = {
    fontDir.enable = true;

    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji

      # nerdfotns
      # https://www.nerdfonts.com/font-downloads
      # items are inferred from the actual downloaded file name
      (nerdfonts.override {
        fonts = [
          "jetBrainsMono"
        ];
      })
    ];
  };
}
