{ pkgs, config, mysecrets, ... }: {
  # Credential for opentelemetry-collector to export telemetry to openobserve cloud
  age.secrets."openobserve" = {
    file = "${mysecrets}/openobserve.age";
    # It is preferable to set systemd user and specify owner
    mode = "0444";
  };

  # Put opentelemetry-collector config file
  environment.etc = {
    "opentelemetry-collector/config.yaml" = {
      mode = "0644";
      text = builtins.readFile ./config.yaml;
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
      EnvironmentFile = [ 
        config.age.secrets.openobserve.path
       ];
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
