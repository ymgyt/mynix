{ ragenix, mysecrets, ... }:
{
  imports = [
    ragenix.nixosModules.default
  ];

  age.identityPaths = [
    "/home/ymgyt/.ssh/nixos_age"
  ];

  age.secrets."foo" = {

    symlink = false;
    path = "/etc/agehandson/foo";
    file = "${mysecrets}/foo.age";
    mode = "0400";
    owner = "root";
    group = "root";
  };
  age.secrets."openobserve" = {
    symlink = false;
    path = "/etc/openobserve/env";
    file = "${mysecrets}/openobserve.age";
    mode = "0444";
  };
}