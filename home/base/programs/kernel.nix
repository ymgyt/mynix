{ pkgs, ... }:
let
  llvm = pkgs.llvmPackages_20;
in
{
  home.packages = with pkgs; [
    b4
    flex
    bison
    bear
    llvm.clang-tools
    llvm.clang
    llvm.lld
  ];
}
