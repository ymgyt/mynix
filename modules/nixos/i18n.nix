{ pkgs, ... }:
{

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };

  # https://nixos.org/manual/nixos/unstable/index.html#module-services-input-methods-fcitx
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-mozc ];
    # https://github.com/NixOS/nixpkgs/blob/1412caf7bf9e660f2f962917c14b1ea1c3bc695e/nixos/modules/i18n/input-method/fcitx5.nix#L24
    # should enable waylandFrontend ?
    # fcitx5.waylandFrontend = true;
  };

}
