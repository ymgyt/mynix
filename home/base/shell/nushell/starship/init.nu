$env.STARSHIP_SHELL = "nu"
$env.STARSHIP_SESSION_KEY = (random chars -l 16)
$env.PROMPT_MULTILINE_INDICATOR = (^starship prompt --continuation)
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""

$env.PROMPT_COMMAND = { ||
  let width = (term size).columns
  ^starship prompt $"--cmd-duration=($env.CMD_DURATION_MS)" $"--status=($env.LAST_EXIT_CODE)" $"--terminal-width=($width)"
}

$env.PROMPT_COMMAND_RIGHT = { ||
  let width = (term size).columns
  ^starship prompt --right $"--cmd-duration=($env.CMD_DURATION_MS)" $"--status=($env.LAST_EXIT_CODE)" $"--terminal-width=($width)"
}

# Replace the full prompt with a compact one after Enter — scrollback stays clean.
$env.TRANSIENT_PROMPT_COMMAND = { ||
  let width = (term size).columns
  ^starship prompt --profile=transient $"--terminal-width=($width)" $"--status=($env.LAST_EXIT_CODE)"
}
$env.TRANSIENT_PROMPT_INDICATOR = ""
$env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = ""
$env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = ""
$env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = ""
$env.TRANSIENT_PROMPT_COMMAND_RIGHT = ""
