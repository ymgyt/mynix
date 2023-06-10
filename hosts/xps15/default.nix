{ ... }: {
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
  ];

  users.users.ymgyt = {
    isNormalUser = true;
    description = "ymgyt";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB8gnwsBvzfnFArlA8+tWWCJ64MjvzwoiTidWEgT3Mbf ymgyt"
    ];
  };

  networking.hostName = "xps15"; # Define your hostname.
}
