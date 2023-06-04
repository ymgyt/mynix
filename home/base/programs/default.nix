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

    # Says
    ponysay
  ];
}
