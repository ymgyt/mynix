{ pkgs, defaultGateway, nameservers, telemetryd, ... }:
let telemetrydStore = telemetryd.packages."${pkgs.system}".telemetryd;
in {
  imports =
    [ ../modules/rpi4.nix ../modules/opentelemetry-collector.nix ../secrets ];

  networking = {
    inherit defaultGateway nameservers;
    hostName = "rpi4-02";
    interfaces.end0.ipv4.addresses = [{
      address = "192.168.10.151";
      prefixLength = 24;
    }];
    wireless.enable = false;
  };

  systemd.services.telemetryd = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    description = "Telemetryd server";
    serviceConfig = { ExecStart = "${telemetrydStore}/bin/telemetryd"; };
  };
}
