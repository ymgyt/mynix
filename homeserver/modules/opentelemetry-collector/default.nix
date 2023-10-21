{ pkgs, config, mysecrets, ... }:
let
  otelColUser = "opentelemetry-collector";
  otelColGroup = otelColUser;
in
{
  # Create user statically for age to execute chown
  users = {
    groups."opentelemetry-collector" = {
      name = "${otelColGroup}";
    };
    users."opentelemetry-collector" = {
      name = "${otelColUser}";
      isSystemUser = true;
      group = "${otelColGroup}";
    };
  };

  # Credential for opentelemetry-collector to export telemetry to openobserve cloud
  age.secrets."openobserve" = {
    file = "${mysecrets}/openobserve.age";
    mode = "0440";
    owner = "${otelColUser}";
    group = "${otelColGroup}";
  };

  # Put opentelemetry-collector config file
  environment.etc = {
    "opentelemetry-collector/config.yaml" = {
      mode = "0440";
      user = "${otelColUser}";
      group = "${otelColGroup}";
      text = builtins.readFile ./config.yaml;
    };
  };

  # Enable opentelemetry-collecotr service
  systemd.services.opentelemetry-collector = {
    description = "Opentelemetry Collector Serivice";
    wantedBy = [ "multi-user.target" ];
    serviceConfig =
      let
        conf =
          "${config.environment.etc."opentelemetry-collector/config.yaml".source.outPath}";
        ExecStart =
          "${pkgs.opentelemetry-collector-contrib}/bin/otelcontribcol --config=file:${conf}";
      in
      {
        inherit ExecStart;
        EnvironmentFile = [
          # referenced by environment variable substitution in config file like '${env:FOO}'
          config.age.secrets.openobserve.path
        ];
        # user
        # age executes chown on secret files, so user and group should exists in advance
        DynamicUser = false;
        User = "${otelColUser}";
        Group = "${otelColGroup}";

        # exec
        Restart = "always";
        WorkingDirectory = "/var/lib/opentelemetry-collector";

        # security
        RemoveIPC = "true";        
        CapabilityBoundingSet = "";
        ProtectSystem = "strict";
        DevicePolicy = "closed";
        NoNewPrivileges = true;
        StateDirectory = "opentelemetry-collector";
      };
  };
}
