{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cmake
    gnumake
    pkg-config-unwrapped
  ];
}
