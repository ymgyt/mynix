{ ... }: {
  nixpkgs.config.allowUnfree = true;

  # enable required by nix-darwin
  # error: The daemon is not enabled but this is a multi-user install, aborting activation
  services.nix-daemon.enable = true;

}
