{ ragenix, ... }: {
  imports = [ ragenix.nixosModules.default ];

  # TODO: remove
  age.identityPaths = [ "/home/ymgyt/.ssh/nixos_age" ];

}
