{ pkgs
, ...
}: {
  imports = [
    ./cargo.nix
    ./filesystem.nix
    ./git.nix
    ./kubernetes.nix
    ./cloud
  ];

  programs = {
    bat.enable = true;
  };

  home.packages = with pkgs; [
    procs
    ripgrep

    # Rust
    rustup

    # Says
    ponysay

    # nix lang server
    nil

    # Provisioning
    terraform

    # Secret management
    vault

    # Etc
    typst
  ];
}
