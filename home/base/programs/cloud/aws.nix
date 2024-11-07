{ pkgs, ... }:
{
  home.packages = with pkgs; [
    awscli2
    aws-vault
    eksctl
    s5cmd
  ];
}
