{
  imports = [
    ./hardware-configuration.nix
    ../../modules/users.nix
    ../../modules/nixos
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ttake";
  
  system.stateVersion = "25.11";
}
