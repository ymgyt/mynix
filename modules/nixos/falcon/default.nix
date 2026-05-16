{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.falcon;

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
{
  options.my.falcon = {
    enable = lib.mkEnableOption "CrowdStrike Falcon Sensor";

    debFile = lib.mkOption {
      type = lib.types.path;
      description = "Path to the falcon-sensor deb file";
    };

    version = lib.mkOption {
      type = lib.types.str;
      description = "Version of falcon-sensor";
    };

    arch = lib.mkOption {
      type = lib.types.str;
      default = "amd64";
      description = "Architecture of falcon-sensor deb file";
    };
  };

  config = lib.mkIf cfg.enable {
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
