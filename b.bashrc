# ~/.bashrc
# Theme: Tokyo Night Minimalist (Text-only) with Time

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ==========================================
# ===== COLORS (Tokyo Night Palette) =======
# ==========================================
RED='\[\e[0;31m\]'
GREEN='\[\e[0;32m\]'
BLUE='\[\e[0;34m\]'
PURPLE='\[\e[0;35m\]'
CYAN='\[\e[0;36m\]'
WHITE='\[\e[0;37m\]'
GREY='\[\e[0;90m\]'
RESET='\[\e[0m\]'

# ==========================================
# ===== PROMPT CONFIGURATION ===============
# ==========================================

parse_git_branch() {
    git rev-parse --is-inside-work-tree &>/dev/null || return
    local BRANCH=$(git branch --show-current 2>/dev/null)
    local STATUS=$(git status --porcelain 2>/dev/null)
    
    if [[ -n "$STATUS" ]]; then
        echo -e "${RED}(${BRANCH}*)${RESET}"
    else
        echo -e "${PURPLE}(${BRANCH})${RESET}"
    fi
}

set_prompt() {
    local EXIT_CODE=$?
    
    # 1. Time (Grey)
    local TIME="${GREY}[$(date +%H:%M:%S)]${RESET}"
    
    # 2. User@Host (Blue)
    local USER_HOST="${BLUE}[${WHITE}\u@\h${BLUE}]${RESET}"
    
    # 3. Directory (Cyan)
    local DIR="${CYAN}\w${RESET}"
    
    # 4. Git Info
    local GIT="$(parse_git_branch)"
    
    # 5. Prompt Char ($ for success, ! for error)
    if [ $EXIT_CODE -eq 0 ]; then
        local CHAR="${GREEN}\$${RESET}"
    else
        local CHAR="${RED}!${RESET}"
    fi
    
    # Layout:
    # [15:30:00] [user@host] ~/path (git)
    # $ 
    PS1="\n${TIME} ${USER_HOST} ${DIR} ${GIT}\n${CHAR} "
}

PROMPT_COMMAND=set_prompt

# ==========================================
# ===== HISTORY & OPTIONS ==================
# ==========================================
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend
shopt -s checkwinsize
shopt -s globstar
shopt -s autocd

# ==========================================
# ===== ALIASES ============================
# ==========================================
alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias ll='ls -alh'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'
alias c='clear'
alias h='history'
alias rm='rm -I'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# ==========================================
# ===== MODERN TOOLS (Optional) ============
# ==========================================
if command -v fzf &>/dev/null; then
    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --color=fg:#a9b1d6,bg:-1,hl:#f7768e,fg+:#c0caf5,bg+:#414868,hl+:#ff9e64,info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff,marker:#9ece6a,spinner:#9ece6a,header:#9ece6a'
fi

# Man Page Colors
export LESS_TERMCAP_md=$'\e[1;34m'
export LESS_TERMCAP_us=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_ue=$'\e[0m'
