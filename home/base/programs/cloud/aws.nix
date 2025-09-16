{ pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    pkgs-unstable.awscli2
    aws-vault
    eksctl
    s5cmd
    pkgs-unstable.amazon-q-cli
    # for ecs exec
    ssm-session-manager-plugin
  ];
}
