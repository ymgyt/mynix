{ pkgs
, ...
}: {
  imports = [
    ./cargo.nix
    ./filesystem.nix
    ./git.nix
  ];

  home.packages = with pkgs; [
    procs
    ripgrep

    # Rust
    rustup

    # Says
    ponysay
  ];
}
