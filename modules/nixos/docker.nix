{ lib, config, ... }:
let
  cfg = config.my.docker;
in
{
  options.my.docker.enable = lib.mkEnableOption "docker with ymgyt in docker group";

  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;
    users.users.ymgyt.extraGroups = [ "docker" ];
  };
}
