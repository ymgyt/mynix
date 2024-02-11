{ config, pkgs, mysecrets, syndicationd, ... }:
let
  syndPkg = syndicationd.packages."${pkgs.system}".synd_api;
  syndUser = "synd";
  syndGroup = syndUser;
in {
  config = {
    # Create user
    users = {
      groups.synd = { name = "${syndGroup}"; };
      users.synd = {
        name = "${syndUser}";
        isSystemUser = true;
        group = "${syndGroup}";
      };
    };

    # Tls certificate and private key
    age.secrets = {
      "syndicationd_certificate" = {
        file = "${mysecrets}/syndicationd_certificate.pem.age";
        mode = "0440";
        owner = "${syndUser}";
        group = "${syndGroup}";
      };

      "syndicationd_private_key" = {
        file = "${mysecrets}/syndicationd_private_key.pem.age";
        mode = "0440";
        owner = "${syndUser}";
        group = "${syndGroup}";
      };
    };

    # Allow synd_api port
    networking.firewall.allowedTCPPorts = [ 5959 ];

    # Enable synd-api service
    systemd.services.synd-api = {
      description = "Syndicationd api";
      wantedBy = [ "multi-user.target" ];
      environment = { RUST_LOG = "INFO"; };
      serviceConfig = let
        cert = config.age.secrets.syndicationd_certificate.path;
        key = config.age.secrets.syndicationd_private_key.path;
        ExecStart =
          "${syndPkg}/bin/synd_api --kvsd-host 192.168.10.151 --kvsd-port 7379 --kvsd-username synd_api --kvsd-password synd_api --tls-cert ${cert} --tls-key ${key}";
      in {
        inherit ExecStart;

        # user
        DynamicUser = false;
        User = "${syndUser}";
        Group = "${syndGroup}";

        # exec
        Restart = "always";
        WorkingDirectory = "/var/lib/synd-api";

        # security
        RemoveIPC = "true";
        CapabilityBoundingSet = "";
        ProtectSystem = "strict";
        DevicePolicy = "closed";
        NoNewPrivileges = true;
        StateDirectory = "synd-api";
      };
    };
  };
}
