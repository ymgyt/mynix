{ ... }:
{
  imports = [
    ./terminal
    ./shell
    ./editor
    ./git
    ./programs
  ];

  home = {
    sessionVariables = {
      EDITOR = "hx";
    };
  };
}
