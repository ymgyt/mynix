use std/dirs
use std/config dark-theme

# Carapace cannot complete aliases on its own; expand the alias's first token
# before delegating, per https://github.com/nushell/nushell/issues/8483.
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

$env.config.show_banner = false
$env.config.buffer_editor = "hx"
$env.config.edit_mode = "vi"
$env.config.render_right_prompt_on_last_line = true
$env.config.show_hints = true
# Pasted multi-line text lands as a single buffer instead of auto-executing each line.
$env.config.bracketed_paste = true
$env.config.use_ansi_coloring = "auto"

$env.config.cursor_shape = {
  vi_insert: "inherit"
  vi_normal: "inherit"
}

$env.config.table = {
  mode: "psql"
  # Show # column only when the data has an explicit index column.
  index_mode: "auto"
  show_empty: true
  padding: { left: 1, right: 1 }
  trim: { methodology: "wrapping", wrapping_try_keep_words: true }
  header_on_separator: true
  footer_inheritance: false
  missing_value_symbol: "❎"
}
# Show footer (column-name row again) only when the header would scroll off-screen.
$env.config.footer_mode = "auto"

$env.config.filesize = {
  # KiB/MiB/GiB (1024-based) — matches actual memory and filesystem sizes.
  unit: "binary"
  show_unit: true
  precision: 1
}
$env.config.float_precision = 2

$env.config.ls = {
  use_ls_colors: true
  clickable_links: false
}

# Fancy with nested formatting for related errors.
$env.config.error_style = "nested"

$env.config.display_errors = {
  exit_code: false
  termination_signal: true
}
$env.config.error_lines = 3

$env.config.rm = {
  always_trash: false
}
# Require `./dir` or absolute paths for cd — bare `src` runs as a command.
$env.config.auto_cd_implicit = false
# Color confirmed externals (shape_external_resolved) differently — catches typos at a glance.
$env.config.highlight_resolved_externals = true
# Alacritty doesn't support Kitty keyboard protocol.
$env.config.use_kitty_protocol = false

$env.config.shell_integration = {
  # Set the terminal window/tab title to cwd + current command.
  osc2: true
  # Report cwd as a URI so terminals can spawn new tabs in the same directory.
  osc7: true
  osc8: true
  # ConEmu/Windows Terminal-specific cwd reporting — unused on Linux.
  osc9_9: false
  # FinalTerm prompt-marking — enables prompt-to-prompt jumps and output folding.
  osc133: true
  # VS Code-specific extension to OSC 133 — not relevant outside VS Code's terminal.
  osc633: false
  # Send ESC[?1l before each prompt to keep cursor-key modes in sync over SSH.
  reset_application_mode: true
}

$env.config.history = {
  # SQLite carries timestamps and session metadata; plaintext does not.
  file_format: "sqlite"
  max_size: 100_000
  sync_on_enter: true
  # Up-arrow in one shell does not surface commands typed in sibling shells.
  isolation: true
  # Commands prefixed with a space are skipped — useful for one-off secrets.
  ignore_space_prefixed: true
}

$env.config.completions = {
  # Fuzzy match — types like `gco` complete to `git checkout`.
  algorithm: "fuzzy"
  # Fuzzy match-score order (prefix/substring would sort alphabetically).
  sort: "smart"
  case_sensitive: false
  quick: true
  partial: true
  use_ls_colors: true
  external: {
    enable: true
    max_results: 100
    completer: $alias_completer
  }
}

$env.config.color_config = (dark-theme)

# direnv: re-export per-directory env before each prompt.
$env.config.hooks.pre_prompt = [{
  code: "direnv export json | from json | default {} | load-env"
}]

$env.config.keybindings = [
  {
    name: history_menu
    modifier: alt
    keycode: char_r
    mode: [vi_insert vi_normal emacs]
    event: { send: menu, name: history_menu }
  }
]
