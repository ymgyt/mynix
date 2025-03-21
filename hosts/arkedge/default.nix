{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ../../modules/users.nix
    ../../modules/falcon
    ../../modules/nixos
  ];

  networking.hostName = "arkedge";
  system.stateVersion = "24.05";
}
