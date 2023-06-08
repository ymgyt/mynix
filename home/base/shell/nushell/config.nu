alias c = cargo
alias g = git
alias m = makers

let-env config = {
  show_banner: false,
  max_history_size: 100000

  edit_mode: vi
}

def book [ ] {
  hx $"($nu.home-path)/rs/techbook"
}
