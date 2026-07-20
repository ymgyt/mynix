{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config.theme = "dark";
  };
  programs.eza.enable = true;
  programs.yazi = {
    enable = true;
    # cd 追従ラッパ (y / yy) は使わないので integration は無効。
    enableNushellIntegration = false;
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
    poppler-utils
    w3m
  ];
}
