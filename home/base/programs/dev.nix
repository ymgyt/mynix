{ pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    pkgs-unstable.just
    direnv
    patchelf
    unzip
    gettext
    protobuf
    cmake
    gnumake
    pkg-config-unwrapped
  ];
}
