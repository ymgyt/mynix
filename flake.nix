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
            pkgs-unstable = import nixpkgs-unstable { inherit system; };
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
      nixosConfigurations = {
        xps15 = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = mkModules {
            inherit system;
            host = "xps15";
          };
        };

        system76 = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = mkModules {
            inherit system;
            host = "system76";
          };
        };
      };

      darwinConfigurations = {
        prox86 = darwin.lib.darwinSystem rec {
          system = "x86_64-darwin";
          modules = mkModules {
            inherit system;
            host = "prox86";
            user = "me";
          };
        };

        fraim = darwin.lib.darwinSystem rec {
          system = "aarch64-darwin";
          modules = mkModules {
            inherit system;
            host = "fraim";
          };
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
