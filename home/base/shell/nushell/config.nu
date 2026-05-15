use std/dirs

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

$env.config.buffer_editor = "hx"
$env.config.show_banner = false
$env.config.edit_mode = "vi"
$env.config.render_right_prompt_on_last_line = true
$env.config.table.mode = "psql"
$env.config.history.file_format = "sqlite"
$env.config.history.max_size = 100_000
$env.config.history.sync_on_enter = true
$env.config.history.isolation = true
$env.config.completions.external.enable = true
$env.config.completions.external.completer = $alias_completer
$env.config.hooks.pre_prompt = [{
  code: "direnv export json | from json | default {} | load-env"
}]
