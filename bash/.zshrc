#=====================================================================
# general config
#=====================================================================

# Import personal profile
source ~/dev/code-snippets/bash/.profile

# Import secrets
source ~/dev/.secrets

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/cp/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/cp/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/cp/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/cp/google-cloud-sdk/completion.zsh.inc'; fi

# Z Shell
setopt auto_cd # cd by directly typing directory name

# To avoid using sudo and sudo-related permission issues, set the N_PREFIX location to something in the user library.
export N_PREFIX=~/.npm
export PATH=$PATH:~/.npm/bin

# Sublime path
export PATH=$PATH:/Applications/Sublime\ Text.app/Contents/SharedSupport/bin

# Virtual environment deactivation
function deactivate_venv() {
    venv_active=$(which deactivate)
    if [[ $venv_active != *"deactivate not found"* ]]; then deactivate; fi
}


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# fuzzy find
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vs code
export PATH="/usr/local/bin/code:$PATH"

# Project-specific
alias cs1="deactivate_venv; cd /Users/cp/dev/cs1/; source .venv39/bin/activate"
alias cs1f="cs1; cd frontend; yarn create:download-translations; cs1; cd apps/create; yarn start"
alias cs1test="cs1; cd apps/create && npx jest"
alias cs1ngTestFile="cs1; cd apps/create; yarn ng test --test-file"
alias cs1b="cs1; npx @bazel/bazelisk run //backend"
alias cs1install="cs1; git pull --rebase; ./installRequirements.sh backend; source .venv39/bin/activate; ./installRequirements.sh frontend sharedjs;"
alias cs1installClean="cs1; git pull --rebase; ./installRequirements.sh --clean;"
alias cs1clone="git clone git@github.com:clipchamp/clipchamp-stack.git cs1; cs1install"

alias cs2="deactivate_venv; cd /Users/cp/dev/cs2/; source .venv39/bin/activate"
alias cs2f="cs2; cd frontend; yarn create:download-translations; cs2; cd apps/create; yarn start"
alias cs2test="cs2; cd apps/create && npx jest"
alias cs2ngTestFile="cs2; cd apps/create; yarn ng test --test-file"
alias cs2b="cs2; npx @bazel/bazelisk run //backend;"
alias cs2install="cs2; git pull --rebase; ./installRequirements.sh backend; source .venv39/bin/activate; ./installRequirements.sh frontend sharedjs;"
alias cs2installClean="cs2; git pull --rebase; ./installRequirements.sh --clean;"
alias cs2clone="git clone git@github.com:clipchamp/clipchamp-stack.git cs2; cs2install"

alias cs3="deactivate_venv; cd /Users/cp/dev/cs3/; source .venv39/bin/activate"
alias cs3f="cs3; cd frontend; yarn create:download-translations; cs3; cd apps/create; yarn start"
alias cs3test="cs3; cd apps/create && npx jest"
alias cs3ngTestFile="cs3; cd apps/create; yarn ng test --test-file"
alias cs3b="cs3; npx @bazel/bazelisk run //backend"
alias cs3install="cs3; git pull --rebase; ./installRequirements.sh backend; source .venv39/bin/activate; ./installRequirements.sh frontend sharedjs;"
alias cs3installClean="cs3; git pull --rebase; ./installRequirements.sh --clean;"
alias cs3clone="git clone git@github.com:clipchamp/clipchamp-stack.git cs3; cs3install"

alias csinstall="gcloud auth application-default login; cs1; gomu; cs1install; cs2; gomu; cs2install; cs3; gomu; cs3install"

alias ccui="cd /Users/cp/dev/ccui/"
alias ccuiinstall="ccui; git pull --rebase; yarn install"
alias ccuiclone="git clone git@github.com:clipchamp/ui.git ccui; ccuiinstall"

alias ccr1="cd /Users/cp/dev/clipchamp-content-repo1/"
alias ccr1fe="cd /Users/cp/dev/clipchamp-content-repo1/apps/portal; yarn start"
alias ccr1be="cd /Users/cp/dev/clipchamp-content-repo1/apps/api; yarn dev"

alias i18n="gcd; cd frontend; yarn create:download-translations"
alias cstypecheck="yarn check-create:watch"

alias db="cd /Users/cp/Dropbox/"
alias dt="cd /Users/cp/Desktop/"
alias dl="cd /Users/cp/Downloads/"
alias dv="cd /Users/cp/dev/"
alias lh4200="o http://localhost:4200/"
alias ghcs="o https://github.com/clipchamp/clipchamp-stack"
alias ghccr="o https://github.com/clipchamp/content-repository"
alias zp="code ~/.zshrc"
alias pp="code ~/dev/code-snippets/bash/.profile"

alias sf="cd /Users/cp/dev/sf"
alias sfb="cd /Users/cp/dev/sf/backend; yarn start;"
alias sff="cd /Users/cp/dev/sf/frontend; yarn start;"

alias mm="cd /Users/cp/dev/memento-mori"
alias mmf="mm; cd frontend; yarn start"
alias mmb="mm; cd backend; yarn start"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git) # careful -- this will quietly override a bunch of custom git aliases

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
