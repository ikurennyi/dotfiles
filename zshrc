# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.


plugins=(git brew macos colored-man-pages colorize npm zsh-autosuggestions zsh-syntax-highlighting)

# User configuration

export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
export ANDROID_HOME="/Users/ek/Library/Android/sdk"

export PATH="$HOME/.rbenv/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
# export MANPATH="/usr/local/man:$MANPATH"

ZSH_DISABLE_COMPFIX="true"
source $ZSH/oh-my-zsh.sh
# load ssh identity
ssh-add>/dev/null 2>&1

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
LANG=en_US.UTF-8


# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="code ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias la='ls -lah'
alias lsl='ls -l'
# alias mine='rubymine'
alias 11ty='npx @11ty/eleventy'

alias ys='yarn start'
alias npm-s='npm start'


# aliases for projects
alias n-t='cd ~/projects/private/nobus/nobus-tracker'
alias n-tapi='cd ~/projects/private/nobus/nobus-tracker-api'
alias nobus='cd ~/projects/private/nobus-website'
alias mixio='cd ~/projects/public/mixio'
alias mixiof='cd ~/projects/public/mixio-front'

# haulmer
alias h-dir='cd ~/projects/clients/haulmer'
alias h-dte='cd ~/projects/clients/haulmer/dte-frontend-platform'
alias h-web='cd ~/projects/clients/haulmer/website-frontend-websites'
alias h-work='cd ~/projects/clients/haulmer/workspace-frontend-platform'



# aliases for capistrano deploy
alias cpd='cap production deploy'
alias csd='cap staging deploy'


# custom git aliases
alias ga='git add'
alias gb='git branch'
alias gd='git diff'
alias gf='git fetch'
alias gco='git checkout'
alias gsw='git switch'
alias gci='git commit'
alias gst='git status'
alias gitk='gitk --all'
alias gitx='gitx --all'
alias glog='git log --graph --abbrev-commit --date=relative --all'
alias git-users='git shortlog -sne --all'
alias grc='git rebase --continue'

export EDITOR='vi'

eval "$(/opt/homebrew/bin/brew shellenv)"

# rbenv initialization
# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
eval "$(rbenv init -)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# START block
# use node version from NVM by reading .nvmrc file in project's folder
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
# END block

###-tns-completion-start-###
if [ -f /Users/ek/.tnsrc ]; then
    source /Users/ek/.tnsrc
fi
###-tns-completion-end-###

function g-switch() {
  git switch $(git branch | grep $1)
}


# Load Angular CLI autocompletion.
source <(ng completion script)
