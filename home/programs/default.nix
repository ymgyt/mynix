{
  pkgs,
  ...
}: {
  imports = [
    ./git.nix
    ./cargo.nix
  ];

  home.packages = with pkgs; [
    exa
    procs
    ripgrep
  ];
}