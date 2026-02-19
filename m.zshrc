# =============================================================================
# POWERLEVEL10K INSTANT PROMPT (MUST be at very top)
# =============================================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
# XDG BASE DIRECTORY SUPPORT
# =============================================================================
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Zinit home (XDG-compliant)
export ZINIT_HOME="${XDG_DATA_HOME}/zinit"

# =============================================================================
# INSTALL ZINIT IF MISSING (only once, during setup)
# =============================================================================
if [[ ! -f "$ZINIT_HOME/zinit.git/zinit.zsh" ]]; then
  print -P "%F{33} %F{220}Installing %F{33}Zinit%F{220} Plugin Manager…%f"
  command mkdir -p "$ZINIT_HOME" && command chmod g-rwX "$ZINIT_HOME"
  command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME/zinit.git" && \
    print -P "%F{34}Installation successful.%f" || \
    print -P "%F{160}Clone failed.%f"
fi

source "$ZINIT_HOME/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# =============================================================================
# ESSENTIAL PLUGINS (load immediately)
# =============================================================================
# Powerlevel10k prompt
zinit ice depth=1; zinit light romkatv/powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Core annexes (required early)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# Lightweight Oh My Zsh snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found
# Uncomment if needed:
# zinit snippet OMZP::aws
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::cubectx

# =============================================================================
# DEFERRED PLUGINS 
# =============================================================================
zinit ice wait lucid; zinit light zsh-users/zsh-completions
zinit ice wait lucid; zinit light zsh-users/zsh-autosuggestions
zinit ice wait lucid; zinit light zdharma-continuum/fast-syntax-highlighting

# fzf: use system-installed files (Arch Linux: /usr/share/fzf/)
if (( $+commands[fzf] )); then
  zinit ice wait lucid; zinit snippet /usr/share/fzf/key-bindings.zsh
  zinit ice wait lucid; zinit snippet /usr/share/fzf/completion.zsh
fi

# =============================================================================
# COMPLETIONS & FINAL INIT
# =============================================================================
# Fast compinit with caching
autoload -Uz +X compinit
if [[ -n "${ZDOTDIR:-$HOME}/.zcompdump"(#qN.mh+20) ]]; then
  compinit -C
else
  compinit
fi
zinit cdreplay -q

# =============================================================================
# HISTORY & NAVIGATION
# =============================================================================
HISTFILE=${XDG_DATA_HOME}/zsh/history
mkdir -p ${XDG_DATA_HOME}/zsh
HISTSIZE=8000
SAVEHIST=8000
setopt appendhistory sharehistory hist_ignore_dups hist_expire_dups_first

# cd by typing directory name
setopt autocd

# =============================================================================
# ENVIRONMENT & ALIASES
# =============================================================================
# LS colors
if (( $+commands[dircolors] )); then
  eval "$(dircolors)"
else
  alias ls='ls --color=auto'
fi

# Basic aliases
alias ll='ls -lh'
alias la='ls -lAh'
alias ..='cd ..'
alias ...='cd ../..'
# Git
alias gs='git status'
alias gd='git diff'
alias gap='git add -p'

# =============================================================================
# TOOLS
# =============================================================================
# zoxide (smart navigation)
eval "$(zoxide init --cmd cd zsh)"

# =============================================================================
# END OF .zshrc
# =============================================================================
