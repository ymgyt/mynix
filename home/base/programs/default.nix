{ pkgs
, ...
}: {
  imports = [
    ./filesystem.nix
    ./git.nix
    ./kubernetes.nix
    ./languages
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

    # Etc(not categorized yet)
    typst
    protobuf # provide protoc
  ];
}
