{ ... }:
{
  imports = [
    ../base
    ./chat.nix
    ./dconf.nix
    ./desktop.nix
    ./ebpf.nix
    ./firefox.nix
    ./hardware.nix
    ./kernel.nix
  ];

  home = {
    username = "ymgyt";
    homeDirectory = "/home/ymgyt";

    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;
}
