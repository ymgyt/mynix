{ config, pkgs, ...}:

{
  home.username = "ymgyt";
  home.homeDirectory = "/home/ymgyt";
  
  programs.git = {
    enable = true;
    userName = "ymgyt";
    userEmail = "yamaguchi7073xtt@gmail.com";
  };
  
  home.packages = with pkgs; [
    exa
    procs
    ripgrep
  ];
  
  programs.alacritty = {
    enable = true;
    settings = {
      # env.TERM = "xterm-256color";
    };
  };
  
  home.stateVersion = "23.11";
  
  programs.home-manager.enable = true;
}