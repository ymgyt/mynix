# git worktree と zellij tab を対にして扱う。
# worktree は <main worktree>.wt/<branch> に置き、tab 名は branch 名にする。
def gwt [] {
  help gwt
}

# main worktree の root。linked worktree から呼んでも main 側を返す。
def gwt-root [] {
  git rev-parse --git-common-dir | str trim | path expand | path dirname
}

def gwt-dir [branch: string] {
  $"(gwt-root).wt" | path join $branch
}

# 今の tab の右隣に開く。new-tab は右端に作るので、元の tab の隣まで左に寄せる。
def gwt-open-tab [branch: string, dir: string] {
  let tabs = (zellij action dump-layout | lines | where $it =~ '^\s*tab ')
  let focused = ($tabs | enumerate | where item =~ 'focus=true' | get index)
  let current = if ($focused | is-empty) { ($tabs | length) - 1 } else { $focused.0 }
  zellij action new-tab --layout wt --cwd $dir --name $branch
  for _ in 0..<(($tabs | length) - $current - 1) {
    zellij action move-tab left
  }
}

# worktree を作り、同名の zellij tab を開く。
# branch が既にあればそれを checkout し、なければ base から作る。
def "gwt new" [
  branch: string                # branch 名。worktree の directory 名にもなる
  base: string = "origin/main"  # 新規 branch の起点
] {
  let dir = (gwt-dir $branch)
  let exists = (do -i { git show-ref --verify --quiet $"refs/heads/($branch)" | complete } | get exit_code) == 0
  if $exists {
    git worktree add $dir $branch
  } else {
    git fetch origin
    git worktree add -b $branch $dir $base
  }
  # direnv は path ごとに allow が要る
  if ($dir | path join ".envrc" | path exists) {
    direnv allow $dir
  }
  gwt-open-tab $branch $dir
}

# 既存の worktree の tab を開く (zellij を立ち上げ直した後など)。
def "gwt open" [branch: string] {
  gwt-open-tab $branch (gwt-dir $branch)
}

# worktree と branch を消し、tab を閉じる。
# tab の中から呼ぶと自分の shell ごと閉じるので、削除を先に行う。
def "gwt rm" [branch: string] {
  git worktree remove (gwt-dir $branch)
  git branch -d $branch
  zellij action go-to-tab-name $branch
  zellij action close-tab
}

def "gwt ls" [] {
  git worktree list
}
