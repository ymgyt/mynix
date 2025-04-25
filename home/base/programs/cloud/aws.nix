{ pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    awscli2
    aws-vault
    eksctl
    s5cmd
    pkgs-unstable.amazon-q-cli
  ];
}
