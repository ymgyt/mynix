# Configure host specific settings

{ pkgs-unstable, ... }:
{
  imports = [ ../../modules/darwin ];

  users.users.ymgyt = {
    home = "/Users/ymgyt";
    shell = pkgs-unstable.nushell;
  };

  networking = {
    hostName = "aem2";
  };
  system.stateVersion = 5;
}
