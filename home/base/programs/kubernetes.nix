{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kubectl
    # 1.1.1 は毎 tick の layout 再計算と API poll で CPU を食い続ける。
    # v2.0.0 の layout cache で改善済みだが nixpkgs が未追従のため一旦外す。
    # kdash
    kustomize
    clusterctl
    kind
    stern
  ];
}
