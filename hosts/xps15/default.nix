{ pkgs, config, ... }: {
  imports = [
    ../../modules/nixos
    ./hardware-configuration.nix
  ];

  users.users.ymgyt = {
    isNormalUser = true;
    description = "ymgyt";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB8gnwsBvzfnFArlA8+tWWCJ64MjvzwoiTidWEgT3Mbf ymgyt"
    ];
  };

  # opentelemetry-collector handson

  environment.etc = {
    "opentelemetry-collector/config.yaml" = {
      mode = "0644";
      # could we separate content into another file?
      text = ''
receivers:
  hostmetrics:
    collection_interval: 1m
    scrapers:
      cpu:
        metrics:
          system.cpu.time: { enabled: false }
          system.cpu.utilization: { enabled: true }
processors:
  resourcedetection/system:
    detectors: ["system"]
    override: false
    attributes: ["host.name"]
    system:
      hostname_sources: ["os"]
exporters:
  logging:
    verbosity: "basic"

service:
  pipelines:
    metrics:
      receivers: [hostmetrics]
      processors: [resourcedetection]
      exporters: [logging]
'';
    };
  };

  systemd.services.opentelemetry-collector = {
    description = "Opentelemetry Collector Serivice";
    wantedBy = ["multi-user.target"];
    serviceConfig = let 
      conf = "${config.environment.etc."opentelemetry-collector/config.yaml".source.outPath}";
      ExecStart = "${pkgs.opentelemetry-collector-contrib}/bin/otelcontribcol --config=file:${conf}";
      in
    {
      inherit ExecStart;
      DynamicUser = true;
      Restart = "always";
      ProtectSystem = "full";
      DevicePolicy = "closed";
      NoNewPrivileges = true;
      WorkingDirectory = "/var/lib/opentelemetry-collector";
      StateDirectory = "opentelemetry-collector";
    };
  };

  networking.hostName = "xps15"; # Define your hostname.
}
