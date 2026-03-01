{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # rustup
    cargo-audit
    cargo-criterion
    cargo-expand
    cargo-hack
    cargo-insta
    cargo-make
    cargo-nextest
    cargo-udeps
    cargo-sort
    cargo-vet
    cargo-bundle-licenses
  ];
}
