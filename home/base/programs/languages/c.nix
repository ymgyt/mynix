{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # clangd
    clang-tools
    bear
  ];
}
