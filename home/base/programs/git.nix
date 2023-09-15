{ pkgs
, ...
}: {
  programs.git = {
    enable = true;
    userName = "ymgyt";
    userEmail = "yamaguchi7073xtt@gmail.com";
    extraConfig = {
      pull = {
        rebase = true;
      };

      init = {
        defaultBranch = "main";
      };
    };

    includes = [
      { path = "~/.gitlocalconfig"; }
    ];

    aliases = {
      a = "add";
      b = "branch -vv";
      d = "diff";
      s = "status";
      l = "log";

      co = "checkout";
      cm = "commit";
    };

  };

  home.packages = with pkgs; [
    git-trim
  ];
}
