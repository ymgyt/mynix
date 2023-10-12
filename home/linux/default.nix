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
    gccgo13
    k3s
    # cgroup utilities
    # getpcaps,capsh, setcap, getcap
    libcap
  ];

  programs.home-manager.enable = true;
}
