{ pkgs, ... }:
{
  environment.systemPackages =
    with pkgs;
    [
      fd
      git
      gcc # for compile procmacro when reading code
      opentelemetry-collector-contrib
      linuxHeaders
      man-pages
      man-pages-posix
    ]
    ++ (with pkgs.gnomeExtensions; [
      kimpanel
      tiling-shell
      blur-my-shell
      system-monitor
      open-bar
      unite
    ]);

  # Set default editor to helix
  environment.variables.EDITOR = "hx";
  environment.variables.__LINUX_HEADER = "${pkgs.linuxHeaders}/include";

  environment.extraInit = ''
    # Disable ssh-askpass
    unset -v SSH_ASKPASS
  '';

}
