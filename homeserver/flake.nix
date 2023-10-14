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
      url =
        "github:ymgyt/mynix.secrets/a09e3d81f8e24657ea2cbd53f37f9e95b4576abb";
      flake = false;
    };

    telemetryd = {
      url = "github:ymgyt/telemetryd/89e37d707417a8f83433dc3bf6d401a786a21ef6";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs =
    { self, nixpkgs, deploy-rs, flake-utils, telemetryd, ragenix, mysecrets }:
    let
      spec = {
        user = "ymgyt";
        defaultGateway = "192.168.10.1";
        nameservers = [ "8.8.8.8" ];
        inherit telemetryd ragenix mysecrets;
      };
    in
    {
      nixosConfigurations = {
        rpi4-01 = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = spec;
          modules = [ ./hosts/rpi4-01.nix ];
        };
        rpi4-02 = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = spec;
          modules = [ ./hosts/rpi4-02.nix ];
        };
        rpi4-03 = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = spec;
          modules = [ ./hosts/rpi4-03.nix ];
        };
        rpi4-04 = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = spec;
          modules = [ ./hosts/rpi4-04.nix ];
        };
      };

      deploy = {
        # Deployment options applied to all nodes
        sshUser = spec.user;
        # User to which profile will be deployed.
        user = "root";
        sshOpts = [ "-p" "22" "-F" "./etc/ssh.config" ];

        fastConnection = false;
        autoRollback = true;
        magicRollback = true;

        # Or setup cross compilation
        remoteBuild = true;

        nodes = {
          rpi4-01 = {
            hostname = "rpi4-01";
            profiles.system = {
              path = deploy-rs.lib.aarch64-linux.activate.nixos
                self.nixosConfigurations.rpi4-01;
            };
          };
          rpi4-02 = {
            hostname = "rpi4-02";
            profiles.system = {
              path = deploy-rs.lib.aarch64-linux.activate.nixos
                self.nixosConfigurations.rpi4-02;
            };
          };
          rpi4-03 = {
            hostname = "rpi4-03";
            profiles.system = {
              path = deploy-rs.lib.aarch64-linux.activate.nixos
                self.nixosConfigurations.rpi4-03;
            };
          };
          rpi4-04 = {
            hostname = "rpi4-04";
            profiles.system = {
              path = deploy-rs.lib.aarch64-linux.activate.nixos
                self.nixosConfigurations.rpi4-04;
            };
          };
        };
      };

      checks = builtins.mapAttrs
        (system: deployLib: deployLib.deployChecks self.deploy)
        deploy-rs.lib;
    } // flake-utils.lib.eachDefaultSystem (system:
    let pkgs = import nixpkgs { inherit system; };
    in {
      devShells.default =
        pkgs.mkShell { buildInputs = [ pkgs.deploy-rs pkgs.nixfmt ]; };
    });
}
