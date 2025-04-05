{ pkgs, ... }:
{
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;

    pinentryPackage = pkgs.pinentry-gnome3;
  };

  home.packages = with pkgs; [
    gnupg
    pinentry-curses
  ];
}
