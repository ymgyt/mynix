{ ... }:
{
  # Enable openssh daemon.
  services.openssh = {
    enable = true;
    settings = {
      # Disable root login
      PermitRootLogin = "no";
      # Disable password login
      PasswordAuthentication = false;
    };
  };
}
