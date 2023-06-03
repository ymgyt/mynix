{ ... }: {
  imports = [
    ./nushell
  ];

  home.shellAliases = {
    c = "cargo";
    g = "git";
    m = "makers";
  };
}