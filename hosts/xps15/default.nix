{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    ./boot.nix
  ];

  networking.hostName = "xps15";
  system.stateVersion = "23.05";

  my = {
    docker.enable = true;
    virtualbox.enable = true;
    libvirt.enable = true;
  };
}
