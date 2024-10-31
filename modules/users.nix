{ ... }:
{
  users.users.ymgyt = {
    isNormalUser = true;
    description = "ymgyt";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
