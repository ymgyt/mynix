{ pkgs, ... }:
{
  home.packages = with pkgs; [
    clang
  ];

  home.file.".cargo/config.toml".text = ''
    [target.x86_64-unknown-linux-gnu]
    linker = "clang"

    [build]
    rustflags = ["-C", "link-arg=--ld-path=${pkgs.wild}/bin/wild"]
  '';
}
