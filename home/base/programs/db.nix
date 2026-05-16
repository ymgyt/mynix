{ pkgs, ... }:
{
  home.packages = with pkgs; [
    postgresql_16
    sqls
  ];
}
