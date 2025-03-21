{ pkgs, ... }:
{
  environment.systemPackages =
    with pkgs;
    [
      fd
      git
      opentelemetry-collector-contrib
    ]
    ++ (with pkgs.gnomeExtensions; [
      kimpanel
      tiling-shell
      blur-my-shell
      system-monitor
      open-bar
    ]);

  # Set default editor to helix
  environment.variables.EDITOR = "hx";

  environment.extraInit = ''
    # Disable ssh-askpass
    unset -v SSH_ASKPASS
  '';

}
