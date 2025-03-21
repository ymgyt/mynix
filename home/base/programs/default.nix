{ pkgs, pkgs-unstable, ... }:
{
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
      config = {
        # theme = "Monokai Extended Origin";
      };
    };
    # error: Package ‘firefox-114.0’ is not available on the requested hostPlatform:
    # hostPlatform.config = "aarch64-apple-darwin"
    firefox.enable = if pkgs.stdenv.isDarwin then false else true;

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
  };

  home.packages = with pkgs; [
    procs
    ripgrep
    bottom
    file
    pkgs-unstable.just # >= 1.32.0 for modules

    # C
    pkg-config-unwrapped
    cmake

    # Says
    ponysay

    # Provisioning
    pkgs-unstable.terraform
    terraform-ls
    tflint

    # Secret management
    vault

    # Data format
    taplo
    jq
    pandoc

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
    dot-language-server

    # Container
    dive

    # Otel
    opentelemetry-collector-contrib # provide otelcontribcol

    # GraphQL
    graphql-client

    # Markdown
    marksman

    # Json
    jsonnet
    jsonnet-language-server

    # Language server for html,css,json
    vscode-langservers-extracted
    biome

    # Language server for code assistance
    lsp-ai

    # Typo
    typos

    # Security
    trivy
    gnupg

    # Text browser
    w3m
    # w3m.override
    # {
    #   graphicsSupport = true;
    # }

    # Etc(not categorized yet)
    pkgs-unstable.typst
    protobuf # provide protoc
    direnv
    fzf
    neofetch
    kbt
  ];
}
