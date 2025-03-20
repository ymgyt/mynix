{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fd
    git
    opentelemetry-collector-contrib
    gnomeExtensions.kimpanel
    gnomeExtensions.tiling-shell
  ];

  # Set default editor to helix
  environment.variables.EDITOR = "hx";

  environment.extraInit = ''
    # Disable ssh-askpass
    unset -v SSH_ASKPASS
  '';

}
