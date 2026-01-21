{ pkgs, config, ... }:
let
  kernelPkg = config.boot.kernelPackages;
  kernel = kernelPkg.kernel;
in
{
  environment.systemPackages = with pkgs; [
    fd
    git
    gcc # for compile procmacro when reading code
    opentelemetry-collector-contrib
    linuxHeaders
    man-pages
    man-pages-posix
    wl-clipboard-rs
    perf

    # 以下のようにstoreにmodule build用のkernelのsrcが生える
    # /nix/store/nx4mdfzx7rkwl9zkqspmfcxxznd92akj-linux-6.12.63-dev/lib/modules/6.12.63/build
    kernel.dev
    kernelPkg.mm-tools
  ];
  # TODO: gnomeの有効性で分岐させたい
  # ++ (with pkgs.gnomeExtensions; [
  #   kimpanel
  #   tiling-shell
  #   blur-my-shell
  #   system-monitor
  #   open-bar
  #   unite
  # ]);

  # Set default editor to helix
  environment.variables.EDITOR = "hx";
  environment.variables.__LINUX_HEADER = "${pkgs.linuxHeaders}/include";
  environment.variables.__KDIR = "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build";

  environment.extraInit = ''
    # Disable ssh-askpass
    unset -v SSH_ASKPASS
  '';
}
