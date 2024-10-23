{
  description = "Deployment for my home server cluster";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.utils.follows = "flake-utils";
    };

    flake-utils.url = "github:numtide/flake-utils";

    # secrets management
    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    mysecrets = {
      url = "github:ymgyt/mynix.secrets/7740a5f2efd0f8bec2f706e3153b89b4a1492f80";
      flake = false;
    };

    telemetryd = {
      url = "github:ymgyt/telemetryd/89e37d707417a8f83433dc3bf6d401a786a21ef6";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    opentelemetry-cli = {
      url = "github:ymgyt/opentelemetry-cli/ffba78aa5d2f1271a29d9e911028af8a28b1c589";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    kvsd = {
      url = "github:ymgyt/kvsd/2dbed99870c87304e04c7c0e63acac249f30df02";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    syndicationd = {
      url = "github:ymgyt/syndicationd/synd-api-v0.2.5";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      deploy-rs,
      flake-utils,
      telemetryd,
      ragenix,
      mysecrets,
      opentelemetry-cli,
      kvsd,
      syndicationd,
    }:
    let
      spec = {
        user = "ymgyt";
        defaultGateway = "192.168.10.1";
        nameservers = [ "8.8.8.8" ];
        inherit
          telemetryd
          ragenix
          mysecrets
          opentelemetry-cli
          kvsd
          syndicationd
          ;
      };
    in
    {
      nixosConfigurations = builtins.listToAttrs (
        builtins.map
          (host: {
            name = host;
            value = nixpkgs.lib.nixosSystem {
              system = "aarch64-linux";
              specialArgs = spec;
              modules = [ ./hosts/${host}.nix ];
            };
          })
          [
            "rpi4-01"
            "rpi4-02"
            "rpi4-03"
            "rpi4-04"
          ]
      );

      deploy = {
        # Deployment options applied to all nodes
        sshUser = spec.user;
        # User to which profile will be deployed.
        user = "root";
        sshOpts = [
          "-p"
          "22"
          "-F"
          "./etc/ssh.config"
        ];

        fastConnection = false;
        autoRollback = true;
        magicRollback = true;
        remoteBuild = false;

        nodes = builtins.mapAttrs (hostname: nixosConfig: {
          inherit hostname;
          profiles.system.path = deploy-rs.lib.aarch64-linux.activate.nixos nixosConfig;
        }) self.nixosConfigurations;
      };

      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.deploy-rs
            pkgs.nixfmt
          ];
        };
      }
    );
}
