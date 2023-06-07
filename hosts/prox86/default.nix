# Configure host specific settings

{ ... }: {
  imports = [ ../../modules/darwin ];

  users.users.me = {
    home = "/Users/me";
  };

  networking = { hostName = "prox86"; };
}
