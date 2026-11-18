{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.falcon-sensor;

  # The sensor binaries expect an FHS layout, so every command runs through
  # the FHS environment of the package.
  fsBash = "${cfg.package}/bin/fs-bash";

  # The sensor keeps its state in /opt/CrowdStrike and replaces its own
  # binaries there when it updates itself, so the files are copied once and
  # left to the sensor afterwards.
  install = pkgs.writeShellScript "falcon-sensor-install" ''
    if [ ! -e /opt/CrowdStrike/falcond ]; then
      ${pkgs.coreutils}/bin/mkdir -p /opt/CrowdStrike
      ${pkgs.coreutils}/bin/cp -a ${cfg.package.unwrapped}/opt/CrowdStrike/. /opt/CrowdStrike/
      ${pkgs.coreutils}/bin/chmod -R u+w /opt/CrowdStrike
    fi
  '';

  setCid = pkgs.writeShellScript "falcon-sensor-set-cid" ''
    if ! /opt/CrowdStrike/falconctl -g --cid > /dev/null 2>&1; then
      /opt/CrowdStrike/falconctl -s --cid=${lib.escapeShellArg cfg.cid}
    fi
  '';
in
{
  options.services.falcon-sensor = {
    enable = lib.mkEnableOption "CrowdStrike Falcon Sensor";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.callPackage ./package.nix { };
      defaultText = lib.literalMD "the falcon-sensor package of this flake";
      description = "The falcon-sensor package to run.";
    };

    cid = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = ''
        Customer ID to register the sensor with. It is set only while the
        sensor has no CID. When null, the CID is left as it is.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    # Follows lib/systemd/system/falcon-sensor.service of the deb.
    systemd.services.falcon-sensor = {
      description = "CrowdStrike Falcon Sensor";
      unitConfig = {
        DefaultDependencies = false;
        RequiresMountsFor = [
          "/opt"
          "/var"
        ];
      };
      after = [ "local-fs.target" ];
      conflicts = [ "shutdown.target" ];
      before = [ "shutdown.target" ];
      wantedBy = [
        "sysinit.target"
        "multi-user.target"
      ];
      serviceConfig = {
        ExecStartPre = [
          install
        ]
        ++ lib.optional (cfg.cid != null) "${fsBash} ${setCid}"
        ++ [
          "${fsBash} -c \"/opt/CrowdStrike/falconctl -g --cid\""
        ];
        ExecStart = "${fsBash} -c /opt/CrowdStrike/falcond";
        Type = "forking";
        PIDFile = "/run/falcond.pid";
        Restart = "no";
        TimeoutStopSec = "60s";
        KillMode = "control-group";
        KillSignal = "SIGTERM";
        Delegate = true;
      };
    };
  };
}
