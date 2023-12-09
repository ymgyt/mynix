{
  imports = [ ./common.nix ];
  services.kubernetes = {
    roles = ["master"];
  };
}