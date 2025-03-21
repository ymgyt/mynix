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

    ./stylix
    ./virtualbox.nix
    ./docker.nix
  ];
}
