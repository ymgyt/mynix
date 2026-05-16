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

    falcon = rec {
      enable = true;
      version = "7.05.0-16004";
      arch = "amd64";
      debFile = /opt/CrowdStrike + "/falcon-sensor_${version}_${arch}.deb";
    };
  };
}
