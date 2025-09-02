{ ... }:
{
  imports = [
    ./debug_info_btf.nix
  ];

  boot.loader.grub.configurationLimit = 10;
}
