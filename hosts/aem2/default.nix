# Configure host specific settings

{pkgs-unstable, ... }:
{
  imports = [ ../../modules/darwin ];

  users.users.ymgyt = {
    home = "/Users/ymgyt";
    # shell = "nu";
    shell = pkgs-unstable.nushell;
  };

  networking = {
    hostName = "aem2";
  };
  nix.package = pkgs-unstable.nixVersions.nix_2_21;
  system.stateVersion = 5;
}
