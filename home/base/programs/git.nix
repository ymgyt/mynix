{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "ymgyt";
    userEmail = "yamaguchi7073xtt@gmail.com";
    delta = {
      enable = true;
      options = {
        dark = true;
      };
    };
    extraConfig = {
      blanch = {
        sort = "-committerdate";
      };

      blame = {
        ignoreRevsFile = ".git-blame-ignore-revs";
      };

      column = {
        ui = "auto";
      };

      color = {
        ui = "auto";
      };

      commit = {
        verbose = true;
      };

      credential = {
        helper = "cache --timeout=604800";
      };

      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };

      fetch = {
        prune = true;
        pruneTags = true;
      };

      init = {
        defaultBranch = "main";
      };

      push = {
        # remoteに同じbranch名でpushする
        # upstreamの設定を要求しない
        default = "current";
      };

      pull = {
        rebase = true;
      };

      tag = {
        sort = "version:refname";
      };
    };

    includes = [ { path = "~/.gitlocalconfig"; } ];

    aliases = {
      a = "add";
      b = "branch -vv";
      d = "diff";
      s = "status";
      l = "log";
      t = "trim --delete local --delete 'merged:*'";

      co = "checkout";
      cm = "commit";
    };
  };

  programs.gitui = {
    enable = true;
  };

  home.packages = with pkgs; [
    git-trim
    git-cliff
  ];
}
