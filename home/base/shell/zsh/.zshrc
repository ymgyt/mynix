# completion
# https://apple.stackexchange.com/questions/296477/my-command-line-says-complete13-command-not-found-compdef
autoload -Uz compinit
compinit
fpath=($fpath ~/.zsh/completion)

bindkey -e

# alias stage

alias g='git'
alias c='cargo'
alias k='kubectl'
alias trim='git checkout main && git pull && git-trim'
alias gcom='git checkout main || git checkout master'

# PATH stage
export PATH="${PATH}:${HOME}/go/bin"
export PATH="${HOME}/.cargo/bin:${PATH}"
export PATH="${HOME}/.local/bin:${PATH}"

export EDITOR=hx
export HELIX_RUNTIME=$HOME/.config/helix/runtime

# zellij workaround
# cargo xtask runでzellijを実行するとzellij projectのrust-toolchainがrespectされるのか
# この環境変数がsetされた状態でsessionが始まる。
# これはprojectのrust-toolchain.tomlをoverrideするので明示的にunsetする
unset RUSTUP_TOOLCHAIN 

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# eval stage

command -v brew      > /dev/null 2>&1 && eval "$(brew shellenv)"
command -v starship  > /dev/null 2>&1 && eval "$(starship init zsh)"
command -v fnm       > /dev/null 2>&1 && eval "$(fnm env)"
command -v direnv    > /dev/null 2>&1 && eval "$(direnv hook zsh)"
command -v kubectl   > /dev/null 2>&1 && eval "$(kubectl completion zsh)"

# def functions

## Ctrl + r -> search shell histoy
function search_history() {
	LBUFFER+=$(fc -ln 1000 | sort |  uniq |  sk )
}
zle -N search_history
bindkey "^r" search_history
