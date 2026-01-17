alias c = cargo
alias g = git
alias j = just
alias k = kubectl
alias m = makers
alias n = nix
alias tf = terraform
alias zr = zellij action rename-tab
alias nd = nix develop

# nu is unable to properly complete aliases. 
# Therefore, based on the workaround below, manually expanding aliases before the completion process.
# https://github.com/nushell/nushell/issues/8483
# https://www.nushell.sh/cookbook/external_completers.html#alias-completions
let alias_completer = {|spans| 
  let expanded_alias = scope aliases
      | where name == $spans.0
      | get -o 0.expansion

  let spans = if $expanded_alias != null {
    $spans
      | skip 1
      | prepend ($expanded_alias | split row ' ' | take 1)
  } else {
    $spans
  }

  carapace $spans.0 nushell ...$spans | from json 
}

$env.config = {
  show_banner: false,
  table: {
    # table --list
    mode:  "psql"
  }
  history: {
    max_size: 100_000
    sync_on_enter: true
    file_format: "sqlite"
    isolation: true
  }
  completions: {
    external: {
      enable: true
      completer: $alias_completer
    }
  }

  edit_mode: vi
}

# Disable SHELL=nu
# ProxyJump in ssh doesn't work well.
# It also affects deploy-rs.
# Probably trying to run nu as shell in remote
# $env.SHELL = "nu"

# TODO: more nu way(find nu files from dir and iterate)
source ~/.config/nushell/completions/cargo-completions.nu
source ~/.config/nushell/completions/git-completions.nu
source ~/.config/nushell/completions/nix-completions.nu
source ~/.config/nushell/completions/poetry-completions.nu
source ~/.config/nushell/completions/typst-completions.nu
source ~/.config/nushell/completions/zellij-completions.nu
source ~/.config/nushell/completions/terraform-completions.nu

# TODO: migrate module
def book [ ] {
  hx $"($nu.home-path)/rs/techbook"
}

def gcom [ ] {
  if (do -i { git checkout main | complete } | get exit_code) == 1 {
    git checkout master
  }
}

# def --env is required for cd to work
# cd means change of environment variable PWD
# therefore, it is necessary to change environment variables outside the function scope
export def --env fraim [ ] {
  let dst = (exa ~/fraim | fzf)
  let go = $"($env.HOME)/fraim/($dst)"
  cd $go
}

# const starship_init_me = "~/.config/nushell/starship/init.nu"

# if ($starship_init_me | path expand | path exists) {
#   source $starship_init_me
# }
use ~/.cache/starship/init.nu
