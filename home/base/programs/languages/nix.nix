{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Language server
    nil
    nix-direnv
    nixfmt-classic
    cachix
  ];
}
