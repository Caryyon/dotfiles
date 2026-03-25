# Gmork ZSH Theme
# Inspired by the black wolf from The NeverEnding Story
# A dark, atmospheric theme with luminous green eyes in blue-black darkness

local reset='%f%b'
local bold='%B'

# Gmork color palette - atmospheric and refined
local green='%F{#3edd78}'         # Luminous green (Gmork's eyes)
local bright_green='%F{#4ade80}'  # Eye shine
local dim_green='%F{#166534}'     # Dim glow
local red='%F{#dc2626}'           # Blood crimson
local bright_red='%F{#ef4444}'    # Bright blood
local orange='%F{#ea580c}'        # Ember orange
local bright_orange='%F{#f97316}' # Bright ember
local purple='%F{#7c3aed}'        # Lightning purple (The Nothing)
local void_purple='%F{#4c1d95}'   # Void purple
local cyan='%F{#22d3ee}'          # Pale cyan
local bright_cyan='%F{#67e8f9}'   # Lightning flash
local white='%F{#f4f4f5}'         # Fang white
local gray='%F{#71717a}'          # Mist
local light_gray='%F{#a1a1aa}'    # Dim foreground

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
    echo "${bright_orange}⇡${reset}"
  fi
}

function git_commits_behind() {
  if [[ -n "$(git rev-list HEAD..@{upstream} 2>/dev/null)" ]]; then
    echo "${purple}⇣${reset}"
  fi
}

function command_status() {
  echo "%(?:${bright_green}◆:${bright_red}◆)${reset}"
}

# Git prompt styling with enhanced status
ZSH_THEME_GIT_PROMPT_PREFIX="${purple}❬${reset}${bright_green}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${purple}❭${reset}"
ZSH_THEME_GIT_PROMPT_DIRTY="${purple}❭${reset} ${red}✗${reset}"
ZSH_THEME_GIT_PROMPT_CLEAN="${purple}❭${reset} ${green}✓${reset}"

# Prompt configuration - atmospheric and minimal
PROMPT='$(command_status) ${green}%c${reset} ${gray}%D{%H:%M}${reset} $(git_prompt_info)
${purple}${bold}❯${reset} '
RPROMPT='${gray}%n${reset}${void_purple}@${reset}${gray}%m${reset}'