{ pkgs, ... }: {
  home.packages = with pkgs; [
    kubectl
    kdash
    kustomize
    clusterctl
    kind
  ];
}
