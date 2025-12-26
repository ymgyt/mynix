{ pkgs, ... }:
{

  imports = [
    ../base
    ./ebpf.nix
    ./dconf.nix
  ];

  home = {
    username = "ymgyt";
    homeDirectory = "/home/ymgyt";

    stateVersion = "23.05";
  };

  # Define packages supported in only linux
  home.packages = with pkgs; [
    # llvm
    # ojbdump
    llvmPackages.bintools
    lldb

    # emulator
    qemu

    # cgroup utilities
    libcgroup
    # capability tools
    # getpcaps,capsh, setcap, getcap
    libcap

    slack
  ];

  programs.home-manager.enable = true;
}
