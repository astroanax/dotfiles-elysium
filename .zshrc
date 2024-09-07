#!/bin/zsh
clear

## Autocompletion
export fpath=($HOME/.completion_zsh/ $fpath)
autoload -Uz compinit && compinit -i
zmodload -i zsh/complist
autoload -Uz is-at-least

zsh_plugins=${ZDOTDIR:-$HOME}/.config/zsh_plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  (
    source '/usr/share/zsh-antidote/antidote.zsh'
    #source /path-to-antidote/antidote.zsh
    antidote bundle <${zsh_plugins}.txt >${zsh_plugins}.zsh
  )
fi
source ${zsh_plugins}.zsh
#antidote load ${ZDOTDIR:-$HOME}/.config/zsh_plugins.txt

setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
# skip confirmation
setopt no_hist_verify
setopt prompt_subst
setopt always_to_end
setopt append_history
setopt auto_menu
setopt complete_in_word
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
setopt interactivecomments
setopt inc_append_history
setopt long_list_jobs
unsetopt CASE_GLOB
unsetopt menu_complete
unsetopt flowcontrol

# fuck 'do you wish to see all possibilities'
# zstyle ':completion:*' list-prompt ''
# zstyle ':completion:*' select-prompt ''
zstyle ':completion:*' special-dirs true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
zstyle ":completion:*:git-checkout:*" sort false
# zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# expand-or-complete-with-dots() {
# print -Pn "%F{red}…%f"
# zle expand-or-complete
# zle redisplay
# }
# zle -N expand-or-complete-with-dots
# bindkey -M vicmd "^I" expand-or-complete-with-dots
# eval `dircolors ~/.dir_colors`
# # pasting
#pasteinit() {
#		OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
#		zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
#}
#pastefinish() {
#		zle -N self-insert $OLD_SELF_INSERT
#}
#zstyle :bracketed-paste-magic paste-init pasteinit
#zstyle :bracketed-paste-magic paste-finish pastefinish
# # ALIASES
#source ~/.aliases
# EXPORTS
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=10000
export WORDCHARS=''
export HISTSIZE=1000000
export HISTFILESIZE=
#export GOPATH=~/dev/go
# export JAVA_HOME=/usr/lib/jvm/java-14-openjdk
# export PATH=$PATH:$JAVA_HOME:/opt/android-sdk/build-tools/30.0.2/
#   Rust
#export PATH=:$PATH:$HOME/.emacs.d/bin:$HOME/.cargo/bin:$HOME/dev/go/bin
# Android
# export NDK=/opt/android-ndk
# Android Studio
#export _JAVA_AWT_WM_NONREPARENTING=1
#export ANDROID_SDK=/opt/android-sdk
#export PATH=$PATH:/opt/android-sdk/build-tools/'30.0.3'/
# export ANDROID_PATH=$ANDROID_SDK/tools:$ANDROID_SDK/platform-tools/
# CCache
#export CCACHE_DIR=/home/phantom/.ccache
#export CCACHE_TEMPDIR=/home/phantom/.ccache
# export RANGER_LOAD_DEFAULT_RC=FALSE
# use fd for fzf
export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# less colors, mainly for man pages
# blink
export LESS_TERMCAP_mb=$'\e[1;33m'
# bold
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
# standout
export LESS_TERMCAP_so=$'\e[01;41;37m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'
# underline
export LESS_TERMCAP_us=$'\e[1;4;32m'
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R'
#export DOTBARE_DIR="$HOME/.dotfiles"
#export DOTBARE_TREE="$HOME"
## fix termite ctrl+shift+t
#source /etc/profile.d/vte.sh
## Fix tmux issues with zsh autosuggestions
# export TERM=xterm-256color
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"
export PAGER=less 
#export RDRVIEW_BROWSER=w3m

# dotbare completion
#_dotbare_completion_cmd
# Vi mode
set -o vi
export EDITOR=vim
# fuck
# eval $(thefuck --alias)
# FZF
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /usr/share/fzf/key-bindings.zsh
# doesnt work anywhere else
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[Z' reverse-menu-complete
bindkey "^I" fzf-tab-complete

# swallowing
#[ -n "$DISPLAY" ]  && command -v xdo >/dev/null 2>&1 && xdo id > /tmp/term-wid-"$$"
#trap "( rm -f /tmp/term-wid-"$$" )" EXIT HUP
#PS1='[\u@\h \W]\$ '
PS1='[%(?..%B(%?%)%b)%n@%m %~]\$ '

export PATH=$PATH:~/bin:~/.local/share/signal-cli/bin

# Created by `pipx` on 2023-11-05 10:37:00
export PATH="$PATH:/home/astroanax/.local/bin"
autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"

cf-c++() {
g++ -Wall -Wextra -Wconversion -static -DONLINE_JUDGE  -O2 -std=c++20 "$1"
}

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# bun completions
[ -s "/home/astroanax/.bun/_bun" ] && source "/home/astroanax/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH:$HOME/go/bin"

libgen(){
	libgen-cli search "$@" -e pdf --sort-by year --sort-asc=false
}
export NVM_DIR="/usr/share/nvm"
source "$NVM_DIR/nvm.sh" # This loads nvm
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
