# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel10k/powerlevel10k"

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


plugins=(git brew macos colored-man-pages colorize npm zsh-autosuggestions zsh-syntax-highlighting fzf-tab zsh-better-npm-completion)

# User configuration

# TODO: Check if I need the next line
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)

# MAVEN_HOME="$HOME/projects/clients/upwork/apache-maven-3.9.7/bin"
# JETBRAINS_SCRIPTS="$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
export PATH="$HOME/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.local/bin/"
# export PATH="$PATH:$MAVEN_HOME:$JETBRAINS_SCRIPTS"


# TODO: zsh again? group maybe?
ZSH_DISABLE_COMPFIX="true"
source $ZSH/oh-my-zsh.sh
# source "$HOME/.cargo/env"
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

alias zj="zellij"

alias n="nvim"

alias la='ls -lah'
alias lsl='ls -l'
alias ,ls="eza --color=always --long --no-filesize --icons=always --no-time"

# homebrew
alias ,bic='brew install --cask'
alias ,bu='brew uninstall'
alias ,bs='brew search'

# npm-related commands
alias ,rd='npm run dev'
alias ,re='npm run test:e2e:parallel'
alias ,ru='npm run test:unit'

# custom git aliases
alias ga='git add'
alias gb='git branch'
alias gd='git diff'
alias gf='git fetch'
alias gco='git checkout'
alias gsw='git switch'
alias gci='git commit'
alias gst='git status'
alias gpr='git pull --rebase'
alias glog='git log --graph --abbrev-commit --date=relative --all'
alias git-users='git shortlog -sne --all'
alias grc='git rebase --continue'
alias grm='git rebase --merge'
alias gc='git clone'
alias ghist="git log --pretty=format:'%C(yellow)[%ad]%C(reset) %C(green)[%h]%C(reset) | %C(red)%s %C(bold red){{%an}}%C(reset) %C(blue)%d%C(reset)' --graph --date=short"

alias fsb=~/projects/private/dotfiles/fsb.sh
alias fshow=~/projects/private/dotfiles/fshow.sh

export EDITOR='vi'

# when using x86_64 (Apple's GPTK), otherwise just keep the first "if"'s eval
if [ "$(arch)" = "arm64" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # rbenv
    eval "$(rbenv init - --no-rehash zsh)"

    # fzf
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
    source <(fzf --zsh)
else
    eval "$(/usr/local/bin/brew shellenv)"
fi

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

function g-switch() {
  git switch $(git branch | grep $1)
}

# source /Users/ik/.docker/init-zsh.sh || true # Added by Docker Desktop

# python
# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
# export PATH="${HOME}/.pyenv/shims:${PATH}"

# TODO: powerline again?
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# TODO: what is this?
# eval "$(gh copilot alias -- zsh)"

# TODO: is these NeoVim related?
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

