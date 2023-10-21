{ pkgs, opentelemetry-cli, ...}:
{
  systemd.timers."cpu-temp-metrics" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      Unit = "cpu-temp-metrics.service";
      OnCalendar = "minutely";
      Persistent = "false";
      AccuracySec = "1m";
     };
  };

  systemd.services."cpu-temp-metrics" = 
  let
    otel = opentelemetry-cli.packages."${pkgs.system}".opentelemetry-cli;
  in
  {
    path = [ 
      pkgs.gawk 
      otel
    ];
    script = builtins.readFile ./script.sh;
    serviceConfig = {
      Type = "oneshot";
      DynamicUser = "true";
      Nice = "19";
    };
  };
}