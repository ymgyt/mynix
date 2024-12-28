{
  imports = [
    ../../modules/users.nix
    ../../modules/nixos
    ./hardware-configuration.nix
    ./boot.nix
    ./falcon.nix
  ];

  networking.hostName = "arkedge";
  system.stateVersion = "24.05";
}
