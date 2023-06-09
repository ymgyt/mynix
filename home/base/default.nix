{ ... }: {
  imports = [
    ./terminal
    ./shell
    ./editor
    ./programs
  ];

  home = {
    sessionVariables = {
      EDITOR = "hx";
    };
  };
}
