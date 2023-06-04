{
  description = "Nix configuration of ymgyt";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";            
    };
  };
  
  outputs = { 
    nixpkgs, 
    home-manager,  
    ... 
  }: {
    nixosConfigurations = {
      xps15 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [ 
          ./hosts/xps15
        
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ymgyt = import ./home;
          }
        ];
      };
    };
  };
}