{ pkgs, config, mysecrets, ... }: {
  # Credential for opentelemetry-collector to export telemetry to openobserve cloud
  age.secrets."openobserve" = {
    symlink = false;
    path = "/etc/openobserve/env";
    file = "${mysecrets}/openobserve.age";
    # It is preferable to set systemd user and specify owner
    mode = "0444";
  };

  # Put opentelemetry-collector config file
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
              memory:
                metrics:
                  system.memory.usage: { enabled: false }
                  system.memory.utilization: { enabled: true }
              network:
                include:
                  interfaces: ["end0"]
                  match_type: strict
                metrics:
                  system.network.connections: { enabled: true }
                  system.network.dropped: { enabled: false }
                  system.network.errors: { enabled: false }
                  system.network.io: { enabled: true }
                  system.network.packets: { enabled: false }
          hostmetrics/fs:
            collection_interval: 60m
            scrapers:
              filesystem:
                exclude_mount_points:
                  mount_points: ["/nix/store"]
                  match_type: strict
                metrics:
                  system.filesystem.inodes.usage: { enabled: false }
                  system.filesystem.usage: { enabled: false }
                  system.filesystem.utilization: { enabled: true }

        processors:
          resourcedetection/system:
            detectors: ["system"]
            override: false
            attributes: ["host.name"]
            system:
              hostname_sources: ["os"]
          filter/metrics:
            error_mode: propagate
            metrics:
              datapoint:
                - >-
                  metric.name == "system.cpu.utilization" 
                  and 
                  ( 
                    attributes["state"] == "nice" 
                    or 
                    attributes["state"] == "softirq" 
                    or 
                    attributes["state"] == "steal" 
                    or 
                    attributes["state"] == "interrupt" 
                  ) 
                - >-
                  metric.name == "system.network.connections"
                  and
                  attributes["state"] != "ESTABLISHED"
                  and
                  attributes["state"] != "LISTEN"

        exporters:
          logging:
            verbosity: "normal"
          prometheusremotewrite/openobserve:
            endpoint: https://api.openobserve.ai/api/''${env:OPEN_OBSERVE_ORG}/prometheus/api/v1/write
            headers:
              Authorization: Basic ''${env:OPEN_OBSERVE_TOKEN}
            resource_to_telemetry_conversion:
              enabled: true

        service:
          pipelines:
            metrics:
              receivers: 
                - hostmetrics
                - hostmetrics/fs
              processors: 
                - resourcedetection/system
                - filter/metrics
              exporters: 
                - logging
                - prometheusremotewrite/openobserve
      '';
    };
  };

  # Enable opentelemetry-collecotr service
  systemd.services.opentelemetry-collector = {
    description = "Opentelemetry Collector Serivice";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = let
      conf =
        "${config.environment.etc."opentelemetry-collector/config.yaml".source.outPath}";
      ExecStart =
        "${pkgs.opentelemetry-collector-contrib}/bin/otelcontribcol --config=file:${conf}";
    in {
      inherit ExecStart;
      # Read age secret
      EnvironmentFile = [ "/etc/openobserve/env" ];
      DynamicUser = true;
      Restart = "always";
      ProtectSystem = "full";
      DevicePolicy = "closed";
      NoNewPrivileges = true;
      WorkingDirectory = "/var/lib/opentelemetry-collector";
      StateDirectory = "opentelemetry-collector";
    };
  };
}
