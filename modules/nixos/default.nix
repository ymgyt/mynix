{ ... }:
{
  imports = [
    ./users.nix

    ./boot
    ./environment.nix
    ./font.nix
    ./networking.nix
    ./nix.nix
    ./programs.nix
    ./services
    ./security.nix
    ./time.nix
    ./i18n.nix

    # Optional feature modules. Each defines my.<name>.enable;
    # hosts opt in by setting it.
    ./falcon
    ./docker.nix
    ./virtualbox.nix
    ./libvirt.nix
    ./kernel-dev.nix
  ];
}
