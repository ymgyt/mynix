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
    bat = {
      enable = true;
      config = {
        theme = "Monokai Extended Origin";
      };
    };
    # error: Package ‘firefox-114.0’ is not available on the requested hostPlatform:
    # hostPlatform.config = "aarch64-apple-darwin"
    firefox.enable = if pkgs.stdenv.isDarwin then false else true;
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
    jq

    # SSH
    openssh # provide ssh ssh-agent ssh-keygen ssh-add scp ssh-keyscan

    # Blog
    zola

    # Etc(not categorized yet)
    typst
    protobuf # provide protoc
    direnv
    fzf
    neofetch
  ];
}
