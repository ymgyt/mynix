{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.libvirt;
in
{
  options.my.libvirt.enable = lib.mkEnableOption "libvirtd for virsh-based VM management";

  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    users.users.ymgyt.extraGroups = [ "libvirtd" ];
    environment.systemPackages = [ pkgs.qemu ];
  };
}
