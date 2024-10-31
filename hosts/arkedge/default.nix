{
  imports = [
    ../../modules/users.nix
    ../../modules/nixos
    ./hardware-configuration.nix
    ./boot.nix
  ];

  networking.hostName = "arkedge";
  system.stateVersion = "24.05";
}
