def book [] {
  hx $"($nu.home-path)/rs/techbook"
}

def gcom [] {
  if (do -i { git checkout main | complete } | get exit_code) == 1 {
    git checkout master
  }
}

def gmsg [n: int = 10] {
  git log --oneline -n $n | fzf --accept-nth 2.. | wl-copy
}

def mdf [] {
  pandoc -t gfm --columns 10000
}
