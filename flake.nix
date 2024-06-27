{
  description = "Nix configuration of ymgyt";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # secrets management
    ragenix.url = "github:yaxitech/ragenix";
  };

  outputs = { nixpkgs, nixpkgs-unstable, darwin, home-manager, ragenix, ... }:
    let
      systems = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
      specialArgs = { inherit ragenix nixpkgs-unstable; };
    in {
      nixosConfigurations = {
        xps15 = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          specialArgs = {
            inherit ragenix;
            pkgs-unstable = import nixpkgs-unstable { inherit system; };
          };

          modules = [
            ./hosts/xps15
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
        prox86 = darwin.lib.darwinSystem rec {
          system = "x86_64-darwin";
          specialArgs = {
            inherit ragenix;
            pkgs-unstable = import nixpkgs-unstable { inherit system; };
          };

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

        fraim = darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          specialArgs = {
            inherit ragenix;
            pkgs-unstable = import nixpkgs-unstable { inherit system; };
          };

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

      formatter =
        forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };

  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html
  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
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
