{ ... }:
{
  imports = [
    ./terminal
    ./shell
    ./editor
    ./programs
  ];

  home = {
    sessionVariables = {
      EDITOR = "hx";
      # NIXOS_OZONE_WL = "1";
    };
  };
}
