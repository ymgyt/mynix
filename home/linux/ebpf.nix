{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bpftools
    bpftrace
  ];
}
