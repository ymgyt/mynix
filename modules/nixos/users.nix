{ pkgs-unstable, ... }:
{
  users.users.ymgyt = {
    isNormalUser = true;
    description = "ymgyt";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs-unstable.nushell;
  };
}
