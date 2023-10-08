{ defaultGateway, nameservers, ... }: {
  imports =
    [ ../modules/rpi4.nix ../modules/opentelemetry-collector ../secrets ];

  networking = {
    inherit defaultGateway nameservers;
    hostName = "rpi4-04";
    interfaces.end0.ipv4.addresses = [{
      address = "192.168.10.153";
      prefixLength = 24;
    }];
    wireless.enable = false;
  };
}
