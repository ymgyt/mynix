{ pkgs, ... }: {
  home.packages = with pkgs; [
    awscli
    eksctl
  ];
}
