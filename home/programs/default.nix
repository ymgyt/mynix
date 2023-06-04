{ pkgs
, ...
}: {
  imports = [
    ./cargo.nix
    ./filesystem.nix
    ./git.nix
    ./util.nix
  ];

  home.packages = with pkgs; [
    procs
  ];
}
