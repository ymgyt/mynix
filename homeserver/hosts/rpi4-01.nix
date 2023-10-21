{ defaultGateway, nameservers, ... }: {
  imports =
    [ ../modules/rpi4.nix ../modules/opentelemetry-collector ../secrets ../modules/metrics ];

  networking = {
    inherit defaultGateway nameservers;
    hostName = "rpi4-01";
    interfaces.end0.ipv4.addresses = [{
      address = "192.168.10.150";
      prefixLength = 24;
    }];
    wireless.enable = false;
  };
}
