alias c = cargo
alias g = git
alias m = makers
alias tf = terraform
alias k = kubectl
alias j = just

$env.config = {
  show_banner: false,
  history: {
    max_size: 100_000
    sync_on_enter: true
    file_format: "plaintext"
    isolation: true
  }

  edit_mode: vi
}

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

# def-env is required for cd to work
# cd means change of environment variable PWD
# therefore, it is necessary to change environment variables outside the function scope
export def-env fraim [ ] {
  let dst = (exa ~/fraim | fzf)
  let go = $"($env.HOME)/fraim/($dst)"
  cd $go
}

const starship_init_me = "~/.config/nushell/starship/init.nu"

if ($starship_init_me | path expand | path exists) {
  source $starship_init_me
}
