{ ... }:
{
  imports = [
    ../../modules/users.nix
    ../../modules/nixos
    ./hardware-configuration.nix
    ./boot.nix
  ];

  networking.hostName = "xps15";
  system.stateVersion = "23.05";
}
