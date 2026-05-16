{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
  ];

  environment.extraInit = ''
    # Disable ssh-askpass
    unset -v SSH_ASKPASS
  '';
}
