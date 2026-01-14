{ pkgs, pkgs-unstable, ... }:
{
  imports = [
    ./cloud
    ./filesystem.nix
    ./git.nix
    ./gpg.nix
    ./kernel.nix
    ./kubernetes.nix
    ./languages
    ./mail.nix
    ./wasm.nix
  ];

  # TODO: mv
  # stylix.targets = {
  #   firefox = {
  #     enable = true;
  #     profileNames = [ "ymgyt" ];
  #     colors.enable = true;
  #     fonts.enable = true;
  #     colorTheme.enable = true;
  #     firefoxGnomeTheme.enable = true;
  #   };
  #   gnome.enable = true; # Helps with dark mode detection even without GNOME
  # };

  programs = {
    bat = {
      enable = true;
      config = {
        # theme = "Monokai Extended Origin";
      };
    };
    # error: Package ‘firefox-114.0’ is not available on the requested hostPlatform:
    # hostPlatform.config = "aarch64-apple-darwin"
    firefox = {
      enable = if pkgs.stdenv.isDarwin then false else true;
      profiles = {
        ymgyt = {
          extensions.force = true;
          settings = {
            # Enable userChrome.css customization for better theming
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            # Force dark mode detection
            "ui.systemUsesDarkTheme" = 1;
            # Dark scrollbars
            "widget.content.allow-gtk-dark-theme" = true;
          };
        };
      };
    };

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
    patchelf
    pkgs-unstable.just # >= 1.32.0 for modules
    unzip
    hexyl

    # C
    pkg-config-unwrapped
    cmake
    gnumake

    # Says
    ponysay

    # Provisioning
    pkgs-unstable.terraform
    pkgs-unstable.terraform-ls
    tflint

    # Secret management
    # vault

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

    # DNS
    dig

    # Tcp
    tcpdump
    lsof

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
    textlint

    # Json
    jsonnet
    jsonnet-language-server

    # SQL
    sqls

    # DB
    postgresql_16

    # Language server for html,css,json
    vscode-langservers-extracted
    biome

    # Language server for code assistance
    lsp-ai

    # Typo
    typos

    # Disk utitlity
    dust

    # Security
    trivy

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
    pciutils
  ];
}
