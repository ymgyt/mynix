# Configure darwin common settings;

{ pkgs, ... }:
{
  imports = [ ];

  nixpkgs.config.allowUnfree = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # enable required by nix-darwin
  # error: The daemon is not enabled but this is a multi-user install, aborting activation
  services.nix-daemon.enable = true;

  nix.settings.trusted-users = [ "ymgyt" ];

  environment.variables = {
    EDITOR = "hx";
  };

  fonts = {
    # nixos use fonts.packages but nix-darwin use fonts.fonts
    # so, currently allow duplication definition
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

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  time.timeZone = "Asia/Tokyo";
}
