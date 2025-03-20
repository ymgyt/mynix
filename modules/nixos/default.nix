{ ... }:
{
  imports = [
    ./environment.nix
    ./font.nix
    ./hardware.nix
    ./networking.nix
    ./nixpkgs.nix
    ./nix.nix
    ./services
    ./security.nix
    ./time.nix
    ./i18n.nix
    ./virtualbox.nix
    ./docker.nix
  ];
}
