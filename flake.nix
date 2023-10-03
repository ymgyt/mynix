{
  description = "Nix configuration of ymgyt";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.05";

    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # secrets management
    ragenix.url = "github:yaxitech/ragenix";
    mysecrets = {
      url = "github:ymgyt/mynix.secrets/c06815267a99c86730de19d467bf7d6182d4eba0";
      flake = false;
    };

    telemetryd.url = "github:ymgyt/telemetryd/a2136807c9a056ec26ff16e8d51c13c6d67a11c3";
  };

  outputs =
    { nixpkgs
    , darwin
    , home-manager
    , ragenix
    , mysecrets
    , telemetryd
    , ...
    }@inputs:
    let
      systems = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
      specialArgs = {
        inherit telemetryd ragenix mysecrets;
      };
    in
    {
      nixosConfigurations = {
        xps15 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          inherit specialArgs;

          modules = [
            ./hosts/xps15
            ./secrets

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ymgyt = import ./home/linux;
              home-manager.extraSpecialArgs = specialArgs;
            }
          ];
        };
      };

      darwinConfigurations = {
        prox86 = darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          inherit specialArgs;

          modules = [
            ./hosts/prox86
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.me = import ./home/darwin;
              home-manager.extraSpecialArgs = specialArgs;
            }
          ];
        };

        fraim = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          inherit specialArgs;

          modules = [
            ./hosts/fraim
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ymgyt = import ./home/darwin;
              home-manager.extraSpecialArgs = specialArgs;
            }
          ];
        };
      };

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };

  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html
  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
    auto-optimise-store = true;

    eval-cache = true;

    substituters = [
      "https://cache.nixos.org/"
    ];
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      # https://app.cachix.org/cache/nix-community#pull
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
