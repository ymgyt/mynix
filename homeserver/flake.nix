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
        "github:ymgyt/mynix.secrets/a7e281a3b609607079a08f15efb812fac03756b7";
      flake = false;
    };

    telemetryd = {
      url = "github:ymgyt/telemetryd/89e37d707417a8f83433dc3bf6d401a786a21ef6";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    opentelemetry-cli = {
      url =
        "github:ymgyt/opentelemetry-cli/ffba78aa5d2f1271a29d9e911028af8a28b1c589";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    kvsd = {
      url = "github:ymgyt/kvsd/b7f3bdb808bf4f146f00305155c74d59b43c2644";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    syndicationd = {
      url =
        "github:ymgyt/syndicationd/d29ba92e929d9d1348fa114ac2bdf210b76c5a1b";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { self, nixpkgs, deploy-rs, flake-utils, telemetryd, ragenix
    , mysecrets, opentelemetry-cli, kvsd, syndicationd }:
    let
      spec = {
        user = "ymgyt";
        defaultGateway = "192.168.10.1";
        nameservers = [ "8.8.8.8" ];
        inherit telemetryd ragenix mysecrets opentelemetry-cli kvsd
          syndicationd;
      };
    in {
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
              remoteBuild = false;
            };
          };
          rpi4-03 = {
            hostname = "rpi4-03";
            profiles.system = {
              path = deploy-rs.lib.aarch64-linux.activate.nixos
                self.nixosConfigurations.rpi4-03;
              remoteBuild = false;
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
        (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    } // flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default =
          pkgs.mkShell { buildInputs = [ pkgs.deploy-rs pkgs.nixfmt ]; };
      });
  nixConfig = {
    extra-substituters = [ "https://homeserver.cachix.org" ];
    extra-trusted-public-keys = [
      "homeserver.cachix.org-1:h0DxBdjH9Euljmp1oaPHZRWKhIFKt6cNefIqz6VOzvs="
    ];
  };
}
