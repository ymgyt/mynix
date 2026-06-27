{ lib, config, ... }:
let
  cfg = config.my.docker;
in
{
  options.my.docker.enable = lib.mkEnableOption "docker with ymgyt in docker group";

  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;
    # Pin container DNS so image pulls survive host network/resolv.conf changes.
    virtualisation.docker.daemon.settings.dns = [ "1.1.1.1" "8.8.8.8" ];
    # kind multi-node routes pods over a pod-CIDR overlay the host has no route
    # back to, so strict reverse-path filtering drops cross-node pod traffic.
    networking.firewall.checkReversePath = false;
    users.users.ymgyt.extraGroups = [ "docker" ];
  };
}
