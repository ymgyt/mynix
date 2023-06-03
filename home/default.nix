{ 
  pkgs, 
  ...
}: {

  imports = [
    ./terminal
    ./shell
    ./editor
    ./programs
  ];

  home = {
    username = "ymgyt";
    homeDirectory = "/home/ymgyt";

    packages = with pkgs; [
      exa
      procs
      ripgrep
    ];

    sessionVariables = {
      EDITOR = "hx";
    };

    stateVersion = "23.11";
  };
  
  programs.home-manager.enable = true;
}