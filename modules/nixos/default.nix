{ ... }:
{
  imports = [
    ./boot
    ./environment.nix
    ./font.nix
    ./hardware.nix
    ./networking.nix
    ./nixpkgs.nix
    ./nix.nix
    ./programs.nix
    ./services
    ./security.nix
    ./time.nix
    ./i18n.nix

    ./falcon
    ./stylix
    ./virtualbox.nix
    ./docker.nix
  ];
}
