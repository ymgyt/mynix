{ ... }:
{
  imports = [
    ../../modules/users.nix
    ../../modules/nixos
    ./hardware-configuration.nix
    ./boot.nix
  ];

  networking.hostName = "system76";
}
