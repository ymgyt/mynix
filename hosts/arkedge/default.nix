{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ../../modules/users.nix
    ../../modules/nixos
  ];

  falconSensor = rec {
    enable = false;
    version = "7.05.0-16004";
    arch = "amd64";
    debFile = /opt/CrowdStrike + "/falcon-sensor_${version}_${arch}.deb";
  };

  # TODO: handle
  boot.blacklistedKernelModules = [ "nouveau" ];
  services.xserver.videoDrivers = [ "modesetting" ];
  boot.kernelParams = [
    "simpledrm.disable=1"
    "i915.enable_guc=0"
    "i915.enable_psr=0"
    "i915.enable_dc=0"
  ];
  boot.initrd.kernelModules = [ "i915" ];

  networking.hostName = "arkedge";
  system.stateVersion = "24.05";
}
