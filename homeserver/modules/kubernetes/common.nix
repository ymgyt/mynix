{
  # networking.firewall.enable = false;
  services.kubernetes = {
    masterAddress = "192.168.10.153";
    apiserverAddress = "https://192.168.10.153:6443";
    dataDir = "/var/lib/kubernetes";
    easyCerts = true;
    featureGates = [ ];
    clusterCidr = "10.1.0.0/16";
  };
}
