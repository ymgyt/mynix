{ ... }: {
  virtualisation.virtualbox = {
    host.enable = true;
    # Guest additions
    guest.enable = true;
    guest.x11 = true;
  };
  users.extraGroups.vboxusers.members = [ "ymgyt" ];
}
