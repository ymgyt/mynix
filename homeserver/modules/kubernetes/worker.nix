{
  imports = [ ./common.nix ];
  services.kubernetes = {
    roles = [ "node" ];
  };
}
