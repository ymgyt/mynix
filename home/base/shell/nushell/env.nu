$env.EDITOR = "hx"

$env.VOLTA_HOME = ($nu.home-path | path join ".volta")
$env.VOLTA_FEATURE_PNPM = "1"

use std/util "path add"
path add "~/.cargo/bin"
path add "~/.volta/bin"
path add "~/.local/bin"
path add "~/.gallop/bin"

source ~/.config/nushell/starship/init.nu
