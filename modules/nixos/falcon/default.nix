{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.falconSensor;

  falcon = pkgs.callPackage ./falcon.nix {
    debFile = cfg.debFile;
    version = cfg.version;
    arch = cfg.arch;
  };

  startPreScript = pkgs.writeScript "init-falcon" ''
    #! ${pkgs.bash}/bin/sh
    /run/current-system/sw/bin/mkdir -p /opt/CrowdStrike
    ln -sf ${falcon}/opt/CrowdStrike/* /opt/CrowdStrike
    ${falcon}/bin/fs-bash -c "${falcon}/opt/CrowdStrike/falconctl -g --cid"
  '';
in
with lib;
{
  options.falconSensor = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable CrowdStrike Falcon Sensor";
    };

    debFile = mkOption {
      type = types.path;
      description = "Path to the falcon-sensor deb file";
    };

    version = mkOption {
      type = types.str;
      description = "Version of falcon-sensor";
    };

    arch = mkOption {
      type = types.str;
      default = "amd64";
      description = "Architecture of falcon-sensor deb file";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.falcon-sensor = {
      enable = true;
      description = "CrowdStrike Falcon Sensor";
      unitConfig.DefaultDependencies = false;
      after = [ "local-fs.target" ];
      conflicts = [ "shutdown.target" ];
      before = [
        "sysinit.target"
        "shutdown.target"
      ];
      serviceConfig = {
        ExecStartPre = "${startPreScript}";
        ExecStart = "${falcon}/bin/fs-bash -c \"${falcon}/opt/CrowdStrike/falcond\"";
        Type = "forking";
        PIDFile = "/run/falcond.pid";
        Restart = "no";
        TimeoutStopSec = "60s";
        KillMode = "process";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
