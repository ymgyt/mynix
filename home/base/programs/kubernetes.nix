{ pkgs, ... }: {
  home.packages = with pkgs; [
    kubectl
    kdash
    kustomize
    k3s
  ];
}
