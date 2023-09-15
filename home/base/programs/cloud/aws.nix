{ pkgs, ... }: {
  home.packages = with pkgs; [
    awscli2
    eksctl
    s5cmd
  ];
}
