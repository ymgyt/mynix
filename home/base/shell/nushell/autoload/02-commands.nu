def book [] {
  hx $"($nu.home-path)/rs/techbook"
}

def gcom [] {
  if (do -i { git checkout main | complete } | get exit_code) == 1 {
    git checkout master
  }
}

def mdf [] {
  pandoc -t gfm --columns 10000
}
