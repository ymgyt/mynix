{ ... }:
{
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
}
