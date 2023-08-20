alias c = cargo
alias g = git
alias m = makers
alias tf = terraform
alias k = kubectl

$env.config = {
  show_banner: false,
  history: {
    max_size: 100_000
    sync_on_enter: true
    file_format: "plaintext"
    isolation: false
  }

  edit_mode: vi
}

# TODO: more nu way(find nu files from dir and iterate)
source ~/.config/nu/completions/cargo-completions.nu
source ~/.config/nu/completions/git-completions.nu
source ~/.config/nu/completions/nix-completions.nu
source ~/.config/nu/completions/poetry-completions.nu
source ~/.config/nu/completions/typst-completions.nu
source ~/.config/nu/completions/zellij-completions.nu

# TODO: migrate module
def book [ ] {
  hx $"($nu.home-path)/rs/techbook"
}

def gcom [ ] {
  if (do -i { git checkout main | complete } | get exit_code) == 1 {
    git checkout master
  }
}

# def-env is required for cd to work
# cd means change of environment variable PWD
# therefore, it is necessary to change environment variables outside the function scope
export def-env fraim [ ] {
  let dst = (exa ~/fraim | fzf)
  let go = $"($env.HOME)/fraim/($dst)"
  cd $go
}

const starship_init_me = "/Users/me/.config/nu/starship/init.nu"

if ($starship_init_me | path exists) {
  source $starship_init_me
}
