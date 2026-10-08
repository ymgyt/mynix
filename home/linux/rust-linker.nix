{ pkgs, ... }:
{
  home.packages = with pkgs; [
    clang
  ];

  home.file.".cargo/config.toml".text = ''
    include = [{ path = "local_config.toml", optional = true }]

    [target.x86_64-unknown-linux-gnu]
    linker = "clang"

    [build]
    rustflags = ["-C", "link-arg=--ld-path=${pkgs.wild}/bin/wild"]
  '';
}
