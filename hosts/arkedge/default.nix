{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
  ];

  users.users.ymgyt = {
    isNormalUser = true;
    description = "ymgyt";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
