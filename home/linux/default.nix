{ pkgs
, ...
}: {

  imports = [
    ../base
  ];

  home = {
    username = "ymgyt";
    homeDirectory = "/home/ymgyt";

    stateVersion = "23.05";
  };

  # Define packages supported in only linux
  home.packages = with pkgs; [
    # llvm

    # gcc
    gcc

    # emulator
    qemu

    # cgroup utilities
    libcgroup
    # capability tools
    # getpcaps,capsh, setcap, getcap
    libcap

    # blockchain
    bitcoin
  ];

  programs.home-manager.enable = true;
}
