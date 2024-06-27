{ ... }: {
  virtualisation.virtualbox = {
    host.enable = true;
    # Guest additions
    guest.enable = true;
  };
  users.extraGroups.vboxusers.members = [ "ymgyt" ];
}
