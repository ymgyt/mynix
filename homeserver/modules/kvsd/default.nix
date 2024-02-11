{ pkgs, config, kvsd, ... }:
let
  kvsdPkg = kvsd.packages."${pkgs.system}".kvsd;
  kvsdUser = "kvsd";
  kvsdGroup = kvsdUser;
in {
  config = {
    # Create user
    users = {
      groups.kvsd = { name = "${kvsdGroup}"; };
      users.kvsd = {
        name = "${kvsdUser}";
        isSystemUser = true;
        group = "${kvsdGroup}";
      };
    };

    # Put kvsd config file
    environment.etc = {
      "kvsd/config.yaml" = {
        mode = "0440";
        user = "${kvsdUser}";
        group = "${kvsdGroup}";
        text = builtins.readFile ./config.yaml;
      };
    };

    # cli
    environment.systemPackages = [ "${kvsdPkg}" ];

    # Enable kvsd service
    systemd.services.kvsd = {
      description = "Kvsd Service";
      wantedBy = [ "multi-user.target" ];
      environment = { KVSD_LOG = "INFO"; };
      serviceConfig = let
        conf = "${config.environment.etc."kvsd/config.yaml".source.outPath}";
        ExecStart =
          "${kvsdPkg}/bin/kvsd server --kvsd-dir /var/lib/kvsd --config ${conf} --disable-tls";
      in {
        inherit ExecStart;

        # user
        DynamicUser = false;
        User = "${kvsdUser}";
        Group = "${kvsdGroup}";

        # exec
        Restart = "always";
        WorkingDirectory = "/var/lib/kvsd";

        # security
        RemoveIPC = "true";
        CapabilityBoundingSet = "";
        ProtectSystem = "strict";
        DevicePolicy = "closed";
        NoNewPrivileges = true;
        StateDirectory = "kvsd";
      };
    };
  };
}
