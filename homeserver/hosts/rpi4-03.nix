{ defaultGateway, nameservers, ... }: {
  imports =
    [ ../modules/rpi4.nix ../modules/opentelemetry-collector.nix ../secrets ];

  networking = {
    inherit defaultGateway nameservers;
    hostName = "rpi4-03";
    interfaces.end0.ipv4.addresses = [{
      address = "192.168.10.152";
      prefixLength = 24;
    }];
    wireless.enable = false;
  };
}
