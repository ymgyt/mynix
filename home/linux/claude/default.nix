{ ... }:
{
  home.file.".local/bin/claude-notify" = {
    source = ./claude-notify;
    executable = true;
  };
}
