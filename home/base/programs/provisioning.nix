{ pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    pkgs-unstable.terraform
    pkgs-unstable.terraform-ls
    tflint
    open-policy-agent
  ];
}
