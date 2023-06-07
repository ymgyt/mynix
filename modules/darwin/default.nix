# Configure darwin common settings;

{ ... }: {
  nixpkgs.config.allowUnfree = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # enable required by nix-darwin
  # error: The daemon is not enabled but this is a multi-user install, aborting activation
  services.nix-daemon.enable = true;

  environment.variables = {
    EDITOR = "hx";
  };

  time.timeZone = "Asia/Tokyo";
}
