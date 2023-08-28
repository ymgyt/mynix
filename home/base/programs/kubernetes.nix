{ pkgs, ... }: {
  home.packages = with pkgs; [
    kubectl
    kdash
    kustomize
    # TODO: not supported in darwin
    # k3s
  ];
}
