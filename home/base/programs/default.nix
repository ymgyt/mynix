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

    # Says
    ponysay

    # Provisioning
    terraform

    # Secret management
    vault

    # Data format
    taplo

    # SSH
    openssh # provide ssh ssh-agent ssh-keygen ssh-add scp ssh-keyscan

    # Etc(not categorized yet)
    typst
    protobuf # provide protoc
    direnv
  ];
}
