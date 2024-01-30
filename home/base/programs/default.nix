{ pkgs, telemetryd, ... }: {
  imports = [
    ./filesystem.nix
    ./git.nix
    ./kubernetes.nix
    ./languages
    ./cloud
    ./wasm.nix
  ];

  programs = {
    bat = {
      enable = true;
      config = { theme = "Monokai Extended Origin"; };
    };
    # error: Package ‘firefox-114.0’ is not available on the requested hostPlatform:
    # hostPlatform.config = "aarch64-apple-darwin"
    firefox.enable = if pkgs.stdenv.isDarwin then false else true;
  };

  home.packages = with pkgs; [
    procs
    ripgrep
    bottom
    just

    # C
    pkg-config-unwrapped
    cmake

    # Says
    ponysay

    # Provisioning
    terraform
    terraform-ls
    tflint

    # Secret management
    vault

    # Data format
    taplo
    jq
    yaml-language-server

    # SSH
    openssh # provide ssh ssh-agent ssh-keygen ssh-add scp ssh-keyscan

    # Blog
    zola

    # Api client
    gh # github cli

    # TLS
    openssl

    # Policy
    open-policy-agent

    # Visualize
    graphviz

    # Container
    dive

    # Otel
    opentelemetry-collector-contrib # provide otelcontribcol

    # GraphQL
    graphql-client

    # Markdown
    marksman

    # Language server for html,css,json
    vscode-langservers-extracted
    biome

    # Etc(not categorized yet)
    typst
    protobuf # provide protoc
    direnv
    fzf
    neofetch
    telemetryd.packages."${pkgs.system}".telemetryd
    kbt
  ];
}
