{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  networking.hostName = "system76";
  system.stateVersion = "24.05";

  my = {
    docker.enable = true;
    virtualbox.enable = true;
    libvirt.enable = true;
    cosmic.enable = true;
  };
}
