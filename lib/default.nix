{ inputs }:
let
  inherit (inputs)
    nixpkgs
    darwin
    home-manager
    myhelix
    ragenix
    ;
  inherit (nixpkgs) lib;

  allowUnfreePackages = [
    "terraform"
    "slack"
    "falcon-sensor"
  ];

  allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowUnfreePackages;

  overlays = import ../overlays;

  hosts = lib.mapAttrs (name: _: import ../hosts/${name}/meta.nix) (
    lib.filterAttrs (_: type: type == "directory") (builtins.readDir ../hosts)
  );

  systems = lib.unique (lib.mapAttrsToList (_: meta: meta.system) hosts);
  forAllSystems = lib.genAttrs systems;

  mkPkgsUnstable =
    system:
    import nixpkgs {
      inherit system overlays;
      config.allowUnfreePredicate = allowUnfreePredicate;
    };

  mkConfig =
    name: meta:
    let
      inherit (meta) system platform;
      user = meta.user or "ymgyt";

      isDarwin = platform == "darwin";
      os = if isDarwin then "darwin" else "linux";

      builder = if isDarwin then darwin.lib.darwinSystem else lib.nixosSystem;
      hmModule =
        if isDarwin then
          home-manager.darwinModules.home-manager
        else
          home-manager.nixosModules.home-manager;

      specialArgs = {
        inherit ragenix myhelix;
        pkgs-unstable = mkPkgsUnstable system;
      };
    in
    builder {
      inherit system specialArgs;
      modules = [
        {
          nixpkgs.overlays = overlays;
          nixpkgs.config.allowUnfreePredicate = allowUnfreePredicate;
        }
        ../hosts/${name}
        hmModule
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users.${user} = import ../home/${os};
          home-manager.extraSpecialArgs = specialArgs;
        }
      ];
    };

  configsFor =
    platform: lib.mapAttrs mkConfig (lib.filterAttrs (_: meta: meta.platform == platform) hosts);
in
{
  inherit
    hosts
    systems
    forAllSystems
    mkConfig
    configsFor
    ;

  formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);

  devShells = forAllSystems (
    system: import ../devshells { pkgs = nixpkgs.legacyPackages.${system}; }
  );
}
