#!/usr/bin/env nu

# Iterate git repos under the given path and clean cargo build artifacts.
# Repos pinned via rust-toolchain(.toml) are cleaned by removing `target/`
# directly to avoid triggering rustup toolchain downloads.
def main [
  path: string = "~/rs"  # target directory to scan
] {
  let root = ($path | path expand)

  if not ($root | path exists) {
    error make { msg: $"path does not exist: ($root)" }
  }

  let repos = (ls $root | where type == dir | get name)

  mut results = []
  for repo in $repos {
    let is_git = ($repo | path join ".git" | path exists)
    let is_cargo = ($repo | path join "Cargo.toml" | path exists)
    let is_pinned = (
      ($repo | path join "rust-toolchain.toml" | path exists)
      or ($repo | path join "rust-toolchain" | path exists)
    )

    if not ($is_git and $is_cargo) {
      $results = ($results | append { repo: $repo, action: "skipped" })
      continue
    }

    if $is_pinned {
      let target = ($repo | path join "target")
      print $"rm target ($target) [pinned toolchain]"
      rm -rf $target
      $results = ($results | append { repo: $repo, action: "rm target" })
    } else {
      print $"cargo clean ($repo)"
      cargo clean --manifest-path ($repo | path join "Cargo.toml")
      $results = ($results | append { repo: $repo, action: "cargo clean" })
    }
  }

  $results
}
