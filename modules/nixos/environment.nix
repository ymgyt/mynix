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
    libnotify
    linuxHeaders
    man-pages
    man-pages-posix
    opentelemetry-collector-contrib
    wl-clipboard-rs
    perf

    # 以下のようにstoreにmodule build用のkernelのsrcが生える
    # /nix/store/nx4mdfzx7rkwl9zkqspmfcxxznd92akj-linux-6.12.63-dev/lib/modules/6.12.63/build
    kernel.dev
    kernelPkg.mm-tools
  ];

  # Set default editor to helix
  environment.variables.EDITOR = "hx";
  environment.variables.__LINUX_HEADER = "${pkgs.linuxHeaders}/include";
  environment.variables.__KDIR = "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build";

  environment.extraInit = ''
    # Disable ssh-askpass
    unset -v SSH_ASKPASS
  '';
}
