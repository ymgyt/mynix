{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.my.git;

  mkClone =
    repo:
    let
      dest = "${config.home.homeDirectory}/${repo.dest}";
    in
    ''
      if [ ! -e "${dest}/.git" ]; then
        run mkdir -p "$(dirname "${dest}")"
        if ! run ${lib.getExe pkgs.git} clone "${repo.url}" "${dest}"; then
          verboseEcho "warning: failed to clone ${repo.url} into ${dest}"
        fi
      else
        verboseEcho "skip: ${dest} already exists"
      fi
    '';

  repoSubmodule = lib.types.submodule {
    options = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to clone this repository. Disable to keep it declared but skipped.";
      };
      url = lib.mkOption {
        type = lib.types.str;
        description = "Git repository URL (HTTPS or SSH).";
      };
      dest = lib.mkOption {
        type = lib.types.str;
        description = "Clone destination, relative to \$HOME.";
      };
    };
  };
in
{
  options.my.git = {
    repos = lib.mkOption {
      type = lib.types.listOf repoSubmodule;
      default = [ ];
      description = "Repositories to clone (once) on home-manager activation.";
    };
  };

  config = {
    my.git.repos = [
      {
        url = "https://github.com/ymgyt/blog.git";
        dest = "rs/blog";
      }
      {
        url = "https://github.com/ymgyt/techbook.git";
        dest = "rs/techbook";
      }
      {
        url = "https://github.com/ymgyt/handson.git";
        dest = "rs/handson";
      }
      {
        url = "https://github.com/ymgyt/drivers.git";
        dest = "rs/drivers";
      }
      {
        url = "https://github.com/ymgyt/helix.git";
        dest = "rs/helix";
      }
      {
        enable = false;
        url = "https://github.com/Rust-for-Linux/linux.git";
        dest = "rs/linux";
      }
      {
        url = "https://github.com/ymgyt/syndicationd.git";
        dest = "rs/syndicationd";
      }
    ];

    home.activation.cloneRepos = lib.hm.dag.entryAfter [ "writeBoundary" ] (
      lib.concatStringsSep "\n" (map mkClone (lib.filter (r: r.enable) cfg.repos))
    );
  };
}
