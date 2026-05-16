{ pkgs, ... }:
{
  home.packages = with pkgs; [
    graphql-client
  ];
}
