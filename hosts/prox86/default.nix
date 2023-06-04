# Configure host specific settings

{ ... }: {
  imports = [ ../../modules/darwin ];

  users.users.me = {
    home = "/Users/me";
    shell = "nu";
  };

  networking = { hostName = "prox86"; };
}
