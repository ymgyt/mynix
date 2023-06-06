# Configure host specific settings

{ ... }: {
  imports = [ ../../modules/darwin ];

  users.users.ymgyt = {
    home = "/Users/ymgyt";
    shell = "nu";
  };

  networking = { hostName = "fraim"; };
}
