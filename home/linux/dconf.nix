{ pkgs, lib, ... }:
{
  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = with pkgs.gnomeExtensions; [
        kimpanel.extensionUuid
        tiling-shell.extensionUuid
        blur-my-shell.extensionUuid
        system-monitor.extensionUuid
        open-bar.extensionUuid
      ];
    };
    "org/gnome/shell/extensions/tilingshell" = {
      inner-gaps = lib.hm.gvariant.mkUint32 8;
      outer-gaps = lib.hm.gvariant.mkUint32 4;
    };
    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      # open-bar で透過させるので、disable
      blur = false;
    };
    "org/gnome/shell/extensions/openbar" = {
      accent-color = [
        "0"
        "0.75"
        "0.75"
      ];
      autofg-bar = true;
      autotheme-font = false;
      balpha = 0.20000000000000001;
      bartype = "Trilands";
      bcolor = [
        "1.0"
        "1.0"
        "1.0"
      ];
      bg-change = true;
      bgalpha = 0.0;
      bgalpha-wmax = 1.0;
      bgalpha2 = 0.0;
      bgcolor = [
        "0.125"
        "0.125"
        "0.125"
      ];
      bgcolor-wmax = [
        "0.125"
        "0.125"
        "0.125"
      ];
      bgcolor2 = [
        "0"
        "0.7"
        "0.75"
      ];
      bottom-margin = 0.0;
      boxalpha = 0.0;
      boxcolor = [
        "0.125"
        "0.125"
        "0.125"
      ];
      bwidth = 1.5;
      candyalpha = 0.0;
      color-scheme = "default";
      dark-fgcolor = [
        "0.604"
        "0.600"
        "0.588"
      ];
      default-font = "Sans 12";
    };
  };
}
