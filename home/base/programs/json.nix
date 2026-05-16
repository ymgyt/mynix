{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jq
    jsonnet
    jsonnet-language-server
  ];
}
