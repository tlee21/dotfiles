# zsh configuration, static plugins
HISTFILE=~/.zsh_history
SAVEHIST=10000
HISTSIZE=50000
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# load custom zsh things
for file in ~/.zcustom/*.zsh; do
    source "$file"
done

# #TODO figure out why these two settings are screwing with zellij
# Environment / Global Settings
#export EDITOR=vim
export KUBE_EDITOR=nvim
# Vim Mods https://dev.to/matrixersp/how-to-use-fzf-with-ripgrep-to-selectively-ignore-vcs-files-4e27 
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"

# Add Homebrew Prefixes as exports and homebrew path to $PATH
eval $(/opt/homebrew/bin/brew shellenv)

# PLUGINS (manually installed)
local FZF_HOME=$HOMEBREW_PREFIX/opt/fzf
[ -f $FZF_HOME/shell/completion.zsh ] && source $FZF_HOME/shell/completion.zsh
[ -f $FZF_HOME/shell/key-bindings.zsh ] && source $FZF_HOME/shell/key-bindings.zsh

local ZSH_HIGH_HOME=$HOMEBREW_PREFIX/share/zsh-syntax-highlighting
[ -f $ZSH_HIGH_HOME/zsh-syntax-highlighting.zsh ] && source $ZSH_HIGH_HOME/zsh-syntax-highlighting.zsh

local ZSH_AUTO=$HOMEBREW_PREFIX/share/zsh-autosuggestions
[ -f $ZSH_AUTO/zsh-autosuggestions.zsh ] && source $ZSH_AUTO/zsh-autosuggestions.zsh

# Shell Completions and Custom zsh functions 
# in case of complaints:  https://github.com/zsh-users/zsh-completions/issues/680#issuecomment-612960481
fpath=( 
    ~/.zfuncs 
    $HOMEBREW_PREFIX/share/zsh/site-functions
    "${fpath[@]}" 
)
autoload -Uz b64hex 
autoload -Uz cargo-build-remote 
autoload -Uz cp-agence-remote
autoload -Uz k8s-pod-bash 
autoload -Uz k8s-pod-forcedelete 

#source <(kubectl completion zsh)
source '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
# allow case-insensitive etc. can copy this later https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/completion.zsh
zstyle ":completion:*" menu yes select
zstyle ":completion:*" matcher-list "" "m:{a-zA-Z}={A-Za-z}" "r:|=*" "l:|=* r:|=*"
autoload -Uz compinit && compinit

# Key bindings 
bindkey "^ " autosuggest-accept
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word
# bindkey "^[a" beginning-of-line
# bindkey "^[e" end-of-line

# aliases
alias g="git"
alias j="just"
alias cat="bat -pp --theme 'Visual Studio Dark+'"
alias catt="bat --theme 'Visual Studio Dark+'"
alias ls="exa --group-directories-first --icons"
alias ll="ls -l --git"
alias la="ll -a"

# zfunc aliases
alias kpbash="k8s-pod-bash"
alias kpfd="k8s-pod-forcedelete"
alias cb-remote="cargo-build-remote"
eval "$(zoxide init zsh)"

# handle theme
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir go_version rust_version nix_shell vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator history background_jobs ram load time)
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true

# Visual customisation of the second prompt line
# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="╭"
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="╰\uF460\uF460\uF460 "
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%{%F{249}%}\u250f"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%F{249}%}\u2517\uf054%{%F{default}%} "

# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} "$"%{%b%f%k%F{yellow}%} %{%f%}"
POWERLEVEL9K_MODE="nerdfont-complete"
source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme

export WASMTIME_HOME="$HOME/.wasmtime"
export PATH="$PATH:/$WASMTIME_HOME/bin"
export PATH="$PATH:/Users/denis/.foundry/bin"
# temporary... alacritty is really lagging with updates
export PATH="$PATH:/Applications/Alacritty.app/Contents/MacOS"
export PATH="$PATH:/opt/homebrew/opt/libpq/bin"
