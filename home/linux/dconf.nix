{ pkgs, lib, ... }:
{
  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = with pkgs.gnomeExtensions; [
        kimpanel.extensionUuid
        tiling-shell.extensionUuid
        blur-my-shell.extensionUuid
        system-monitor.extensionUuid
      ];
    };
    "org/gnome/shell/extensions/tilingshell" = {
      inner-gaps = lib.hm.gvariant.mkUint32 8;
      outer-gaps = lib.hm.gvariant.mkUint32 4;
    };
  };
}
