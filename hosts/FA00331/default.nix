{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  networking.hostName = "FA00331";
  system.stateVersion = "25.11";

  my = {
    docker.enable = true;
    libvirt.enable = true;
    kernel-dev.enable = true;
    cosmic.enable = true;
  };

  services.falcon-sensor.enable = true;
}
