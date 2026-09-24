{ pkgs, ... }:
let
  retroWave = builtins.readFile (
    pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/zellij-org/zellij/v0.45.1/zellij-utils/assets/themes/retro-wave.kdl";
      hash = "sha256-gdiiTp4OzsjZn3hJgOyrWtN2oy93+0DC/ynaxsNAPLc=";
    }
  );
  readableRetroWave =
    builtins.replaceStrings
      [
        ''
          text_selected {
                      base 255 255 255
                      background 26 26 26''
      ]
      [
        ''
          text_selected {
                      base 255 255 255
                      background 96 96 96''
      ]
      retroWave;
in
{
  programs.zellij = {
    enable = true;
  };

  xdg.configFile."zellij/config.kdl".source = ./config.kdl;
  xdg.configFile."zellij/themes/retro-wave.kdl".text =
    assert readableRetroWave != retroWave;
    readableRetroWave;
  xdg.configFile."zellij/layouts/minimal.kdl".text = ''
    layout {
        pane size=1 borderless=true {
            plugin location="compact-bar"
        }
        pane
    }
  '';
}
