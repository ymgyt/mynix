{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cmake
    gnumake
    pkg-config-unwrapped
    llvmPackages_20.clang-tools
  ];
}
