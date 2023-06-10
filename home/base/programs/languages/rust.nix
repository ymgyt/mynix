{ pkgs, ... }: {
  home.packages = with pkgs; [
    rustup 
    cargo-criterion
    cargo-deps
    cargo-expand
    cargo-insta
    cargo-make
    cargo-nextest
    cargo-udeps
    cargo-sort
    cargo-vet
  ];
}
