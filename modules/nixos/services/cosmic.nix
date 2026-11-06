{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.cosmic;
in
{
  options.my.cosmic.enable = lib.mkEnableOption "COSMIC desktop with cosmic-greeter and system76-scheduler";

  config = lib.mkIf cfg.enable {
    services = {
      displayManager.cosmic-greeter.enable = true;
      desktopManager.cosmic = {
        enable = true;
        showExcludedPkgsWarning = true;
        xwayland.enable = true;
      };

      system76-scheduler.enable = true;
    };

    environment.cosmic.excludePackages = with pkgs; [
      cosmic-edit
      # cosmic-osk (on-screen keyboard) が fcitx5 より先に zwp_input_method_v2 を取り、
      # Wayland アプリで日本語入力が効かなくなる。修正版が nixpkgs に入ったら外す。
      # https://github.com/pop-os/cosmic-osk/issues/44
      cosmic-osk
    ];
  };
}
