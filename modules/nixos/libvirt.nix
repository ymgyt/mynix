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
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        # virtios-fs backend
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
    # defaultの接続先を指定しておく
    environment.variables.LIBVIRT_DEFAULT_URI = "qemu:///system";
    users.users.ymgyt.extraGroups = [ "libvirtd" ];
    environment.systemPackages = with pkgs; [
      libosinfo
      qemu
      virt-viewer
      virt-manager
    ];
  };
}
