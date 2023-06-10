{ ... }: {
  services.openssh = {
    enable = true;
    settings.PermitRootLogin = false;
  };
}
