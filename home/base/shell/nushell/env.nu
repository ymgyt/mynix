# https://www.nushell.sh/book/environment.html#environment-variable-conversions
# https://github.com/nushell/nushell/blob/main/crates/nu-utils/src/sample_config/default_env.nu
# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
}

$env.EDITOR = "hx"
$env.SHELL = "nu"

# https://github.com/nushell/nu_scripts/blob/main/nu-hooks/direnv/config.nu
$env.config = {
  hooks: {
    pre_prompt: [{
      code: "
        direnv export json | from json | default {} | load-env
      "
    }]
  }
}

mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""

const local = "~/.config/nushell/local.nu"
if ($local | path exists) {
  source $local
}

# Add cargo commands to PATH
$env.PATH = ($env.PATH | prepend "~/.cargo/bin")

# Configure volta
$env.VOLATA_HOME = "~/.volta"
$env.PATH = ($env.PATH | prepend "~/.volta/bin")
