{ config, pkgs,... }:
let
  masterIp = "192.168.10.153";
  masterHostname = "rpi4-04";
  masterApiServerPort = 6443;
in
{
  networking.extraHosts = "${masterIp} ${masterHostname}";
  # imports = [ ./common.nix ];
  # TODO: add kubectl

  services.kubernetes = {
    roles = ["master"];
    masterAddress = masterHostname;
    apiserverAddress = "https://${masterHostname}:${toString masterApiServerPort}";
    easyCerts = true;
    featureGates = [];
    clusterCidr = "10.1.0.0/16";
    apiserver = {
      securePort = masterApiServerPort;
      advertiseAddress = masterIp;
    };

    addons.dns.enable = true;
    # kubelet.extraOpts = "--fail-swap-on=false";
  };
}