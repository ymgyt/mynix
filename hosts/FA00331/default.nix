{
  imports = [
    ./hardware-configuration.nix
    ../../modules/users.nix
    ../../modules/nixos
  ];

  falconSensor = rec {
    enable = false;
    version = "7.05.0-16004";
    arch = "amd64";
    debFile = /opt/CrowdStrike + "/falcon-sensor_${version}_${arch}.deb";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "FA00331";
  system.stateVersion = "25.11";
}
