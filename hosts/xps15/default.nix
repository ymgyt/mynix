{ ... }:
{
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
  ];

  users.users.ymgyt = {
    isNormalUser = true;
    description = "ymgyt";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  networking.hostName = "xps15"; # Define your hostname.
}
