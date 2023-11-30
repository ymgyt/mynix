{ pkgs, ... }: {
  home.packages = with pkgs; [
    wabt
  ];
}
