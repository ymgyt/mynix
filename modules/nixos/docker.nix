{ ... }: {
  virtualisation.docker.enable = true;
  users.users."ymgyt".extraGroups = [ "docker" ];
}
