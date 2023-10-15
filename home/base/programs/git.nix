{ pkgs
, ...
}: {
  programs.git = {
    enable = true;
    userName = "ymgyt";
    userEmail = "yamaguchi7073xtt@gmail.com";
    extraConfig = {
      push = {
        # remoteに同じbranch名でpushする
        # upstreamの設定を要求しない
        default = "current";
      };

      pull = {
        rebase = true;
      };

      init = {
        defaultBranch = "main";
      };

      color = {
        ui = "auto";
      };

      credential = {
        helper = "cache --timeout=604800";
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

  programs.gitui = {
    enable = true;
  };

  home.packages = with pkgs; [
    git-trim
  ];
}
