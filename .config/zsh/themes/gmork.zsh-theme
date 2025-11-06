# Gmork ZSH Theme
# Inspired by the mystical dark Neovim colorscheme
# Color palette extracted from the Gmork Neovim theme

# Use bright electric colors for maximum vibrancy and supernatural glow
local reset='%f%b'
local bold='%B'

# Define color variables using bright electric colors for maximum vibrancy
local green='%F{#00ff00}'         # Pure electric green
local bright_green='%F{#88ff00}'  # Electric lime green
local eerie_green='%F{#00ff88}'   # Bright neon green
local orange='%F{#ff4400}'        # Electric orange
local red='%F{#ff0000}'           # Pure blazing red
local purple='%F{#ff00ff}'        # Pure electric magenta
local blue='%F{#0088ff}'          # Electric blue
local cyan='%F{#00ffff}'          # Electric cyan
local brown='%F{#ff8800}'         # Molten orange
local white='%F{#ffffff}'         # Pure glowing white
local gray='%F{#555555}'          # LIGHT_GRAY
local dark_gray='%F{#2f2f2f}'     # DARK_GRAY

# Git status function
function git_prompt_info() {
  local ref
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "true" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

function parse_git_dirty() {
  local STATUS
  local -a FLAGS
  FLAGS=('--porcelain')
  if [[ "$(command git config --get oh-my-zsh.hide-dirty)" != "true" ]]; then
    if [[ "${DISABLE_UNTRACKED_FILES_DIRTY:-}" == "true" ]]; then
      FLAGS+='--untracked-files=no'
    fi
    STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -1)
  fi
  if [[ -n $STATUS ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# Additional status functions
function git_commits_ahead() {
  if [[ -n "$(git rev-list @{upstream}..HEAD 2>/dev/null)" ]]; then
    echo "${orange}⇡${reset}"
  fi
}

function git_commits_behind() {
  if [[ -n "$(git rev-list HEAD..@{upstream} 2>/dev/null)" ]]; then
    echo "${blue}⇣${reset}"
  fi
}

function command_status() {
  echo "%(?:${green}⚡:${red}⚡)${reset}"
}

# Git prompt styling with enhanced status
ZSH_THEME_GIT_PROMPT_PREFIX="${cyan}[${reset}${bright_green}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${cyan}]${reset}"
ZSH_THEME_GIT_PROMPT_DIRTY="${cyan}]${reset} ${red}✗${reset}"
ZSH_THEME_GIT_PROMPT_CLEAN="${cyan}]${reset} ${green}✓${reset}"

# Prompt configuration with command status - clean and minimal
PROMPT='$(command_status) ${green}%c${reset} [%D{%H:%M:%S}] $(git_prompt_info)
${red}${bold}❯${reset} '
RPROMPT='${gray}%n@%m${reset}'