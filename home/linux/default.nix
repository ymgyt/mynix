{ pkgs
, ...
}: {

  imports = [
    ../base
  ];

  home = {
    username = "ymgyt";
    homeDirectory = "/home/ymgyt";

    packages = with pkgs; [
      exa
      procs
      ripgrep
    ];

    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
