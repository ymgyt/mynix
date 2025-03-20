{
  description = "Nix configuration of ymgyt";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # secrets management
    ragenix.url = "github:yaxitech/ragenix";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      darwin,
      home-manager,
      ragenix,
      ...
    }:
    let
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;

      mkModules =
        {
          host,
          system,
          user ? "ymgyt",
        }:
        let
          # substritute "x86_64-linux" => "linux"
          os = builtins.elemAt (builtins.match ".*-(.*)" system) 0;
          specialArgs = {
            inherit ragenix;
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [ "terraform" ];
            };
          };

        in
        [
          ./hosts/${host}
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = import ./home/${os};
            home-manager.extraSpecialArgs = specialArgs;
          }
        ];
    in
    {
      nixosConfigurations =
        builtins.mapAttrs
          (
            host: system:
            nixpkgs.lib.nixosSystem {
              inherit system;
              modules = mkModules { inherit system host; };
            }
          )
          {
            xps15 = "x86_64-linux";
            system764 = "x86_64-linux";
            arkedge = "x86_64-linux";
          };

      darwinConfigurations = {
        prox86 = darwin.lib.darwinSystem rec {
          system = "x86_64-darwin";
          specialArgs = {
            inherit ragenix;
            pkgs-unstable = import nixpkgs-unstable { inherit system; };
          };
          modules = [

            ./hosts/aem2
            (import ./overlays)
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ymgyt = import ./home/darwin;
              home-manager.extraSpecialArgs = specialArgs;
            }
          ];
        };

        aem2 = darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          specialArgs = {
            inherit ragenix;
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [ "terraform" ];
            };
          };
          modules = [
            ./hosts/aem2
            (import ./overlays)
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
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
    auto-optimise-store = true;

    eval-cache = true;

    substituters = [ "https://cache.nixos.org/" ];
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [

      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
