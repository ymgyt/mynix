{ ... }:
{
  imports = [
    ../base
    ./chat.nix
    ./claude
    ./dconf.nix
    ./desktop.nix
    ./ebpf.nix
    ./firefox.nix
    ./hardware.nix
    ./monitor.nix
    ./rust-linker.nix
    ./sandbox.nix
    ./kernel.nix
  ];

  home = {
    username = "ymgyt";
    homeDirectory = "/home/ymgyt";

    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;
}
