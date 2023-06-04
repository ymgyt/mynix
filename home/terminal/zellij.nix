{ ... }: {
  programs.zellij = {
    enable = true;
    settings = {
      default_shell = "nu";
      copy_clipboard = "primary";
      copy_on_select = true;
    };
  };
}
