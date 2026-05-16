{ lib, config, ... }:
let
  cfg = config.my.virtualbox;
in
{
  options.my.virtualbox.enable = lib.mkEnableOption "VirtualBox host and guest additions";

  config = lib.mkIf cfg.enable {
    virtualisation.virtualbox = {
      host.enable = true;
      guest.enable = true;
    };
    users.extraGroups.vboxusers.members = [ "ymgyt" ];
  };
}
