{ pkgs, ... }:
{
  programs.bat.enable = true;
  programs.eza.enable = true;
  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      mgr = {
        show_hidden = true;
        sort_by = "natural";
        sort_dir_first = true;
        sort_sensitive = false;
        linemode = "size";
        show_symlink = true;
      };
      preview = {
        wrap = "yes";
        tab_size = 2;
      };
      opener.edit = [
        {
          run = ''hx "$@"'';
          block = true;
          for = "unix";
        }
      ];
    };
  };

  home.packages = with pkgs; [
    file
    hexyl
    w3m
  ];
}
