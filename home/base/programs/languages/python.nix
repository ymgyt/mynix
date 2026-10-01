{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Language server (helix の python の既定は ty と ruff)
    ty
    ruff
  ];
}
