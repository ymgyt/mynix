{
  description = "Nix configuration of ymgyt";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    myhelix.url = "github:ymgyt/helix/explorer";

    # secrets management
    ragenix.url = "github:yaxitech/ragenix";
  };

  outputs =
    inputs:
    let
      mylib = import ./lib { inherit inputs; };
    in
    {
      nixosConfigurations = mylib.configsFor "nixos";
      darwinConfigurations = mylib.configsFor "darwin";

      formatter = mylib.formatter;
      devShells = mylib.devShells;

      # exposed for `nix repl` / `nix eval` introspection.
      lib = mylib;
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
