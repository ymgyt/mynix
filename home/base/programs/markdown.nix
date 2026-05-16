{ pkgs, ... }:
{
  home.packages = with pkgs; [
    marksman
    textlint
    pandoc
    (writeShellApplication {
      name = "mdfmt";
      runtimeInputs = [ pandoc ];
      text = ''
        exec pandoc -t gfm --columns=1000
      '';
    })
  ];
}
