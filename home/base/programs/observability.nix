{ pkgs, ... }:
{
  home.packages = with pkgs; [
    opentelemetry-collector-contrib
  ];
}
