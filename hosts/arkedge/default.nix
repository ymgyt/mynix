{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ../../modules/users.nix
    ../../modules/nixos
  ];

  falconSensor = rec {
    enable = true;
    version = "7.05.0-16004";
    arch = "amd64";
    debFile = /opt/CrowdStrike + "/falcon-sensor_${version}_${arch}.deb";
  };
  networking.hostName = "arkedge";
  system.stateVersion = "24.05";
}
