{ pkgs, ... }: {
  home.packages = with pkgs; [
    awscli
    eksctl
    s5cmd
  ];
}
