{ pkgs, ... }:
let
  email = "yamaguchi7073xtt@gmail.com";
in
{
  programs.git = {
    enable = true;
    # for git send-email
    package = pkgs.gitFull;
    userName = "ymgyt";
    userEmail = email;
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
        # これを指定すると常に探しにいき、見つからないとエラーになる
        # ignoreRevsFile = ".git-blame-ignore-revs";
      };

      column = {
        ui = "auto";
      };

      color = {
        ui = "auto";
      };

      commit = {
        verbose = true;
        # Add Signed-off-by: tag
        signoff = true;
      };

      core = {
        # https://docs.kernel.org/process/submitting-patches.html
        abbrev = "12";
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

      pretty = {
        # https://docs.kernel.org/process/submitting-patches.html
        fixes = "Fixes: %h (\"%s\")";
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

      sendemail = {
        smtpServer = "smtp.gmail.com";
        smtpServerPort = 587;
        smtpEncryption = "tls";
        smtpUser = email;
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
