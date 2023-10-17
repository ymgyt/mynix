{ pkgs, ...}:
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

  systemd.services."cpu-temp-metrics" = {
    path = [ pkgs.gawk ];
    script = builtins.readFile ./script.sh;
    serviceConfig = {
      Type = "oneshot";
      DynamicUser = "true";
      Nice = "19";
    };
  };
}