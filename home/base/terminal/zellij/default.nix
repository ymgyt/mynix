{ ... }:
{
  programs.zellij = {
    enable = true;
  };

  xdg.configFile."zellij/config.kdl".source = ./config.kdl;
  xdg.configFile."zellij/layouts/minimal.kdl".text = ''
    layout {
        pane size=1 borderless=true {
            plugin location="tab-bar"
        }
        pane
    }
  '';
}
