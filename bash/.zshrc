#=====================================================================
# general config
#=====================================================================

# Import personal profile
source ~/dev/code-snippets/bash/.profile

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/cjp/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/cjp/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/cjp/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/cjp/google-cloud-sdk/completion.zsh.inc'; fi

# Virtualenvwrapper
# https://virtualenvwrapper.readthedocs.io/en/latest/install.html
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh

# Z Shell
setopt auto_cd # cd by directly typing directory name

# To avoid using sudo and sudo-related permission issues, set the N_PREFIX location to something in the user library.
export N_PREFIX=~/.npm
export PATH=$PATH:~/.npm/bin

# Sublime path
export PATH=$PATH:/Applications/Sublime\ Text.app/Contents/SharedSupport/bin

# Project-specific
alias cs1="cd /Users/cjp/dev/cs1/"
alias cs1f="cd /Users/cjp/dev/cs1/frontend; npm run start-create"
alias cs1test="cd /Users/cjp/dev/cs1/frontend; npx ng test --test-file"
alias cs1b="cd /Users/cjp/dev/cs1/backend; workon cs1; gulp webserver-gae"
alias cs1install="cs1; git pull --rebase; mkvirtualenv cs1; workon cs1; ./installRequirements.sh; yarn install; cd libs/shared-js/; npm run build; cs1"
alias cs1clone="git clone git@github.com:clipchamp/clipchamp-stack.git cs1; cs1install"

alias cs2="cd /Users/cjp/dev/cs2/"
alias cs2f="cd /Users/cjp/dev/cs2/frontend; npm run start-create"
alias cs2test="cd /Users/cjp/dev/cs2/frontend; npx ng test --test-file"
alias cs2b="cd /Users/cjp/dev/cs2/backend; workon cs2; gulp webserver-gae"
alias cs2install="cs2; git pull --rebase; mkvirtualenv cs2; workon cs2; ./installRequirements.sh; yarn install; cd libs/shared-js/; npm run build; cs2"
alias cs2clone="git clone git@github.com:clipchamp/clipchamp-stack.git cs2; cs2install"

alias ccui="cd /Users/cjp/dev/ccui/"
alias ccuiinstall="ccui; git pull --rebase; yarn install"
alias ccuiclone="git clone git@github.com:clipchamp/ui.git ccui; ccuiinstall"

alias ccr1="cd /Users/cjp/dev/clipchamp-content-repo1/"
alias ccr1fe="cd /Users/cjp/dev/clipchamp-content-repo1/apps/portal; yarn start"
alias ccr1be="cd /Users/cjp/dev/clipchamp-content-repo1/apps/api; yarn dev"

alias i18n="cd frontend/apps/create && npx lingui extract"

alias db="cd /Users/cjp/Dropbox/"
alias dt="cd /Users/cjp/Desktop/"
alias dl="cd /Users/cjp/Downloads/"
alias dv="cd /Users/cjp/dev/"
alias lh="o http://localhost:4200/"
alias ghcs="o https://github.com/clipchamp/clipchamp-stack"
alias ghccr="o https://github.com/clipchamp/content-repository"
alias zp="code ~/.zshrc"
alias pp="code ~/dev/code-snippets/bash/.profile"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

#=====================================================================
# oh-my-zsh configuration
#=====================================================================

# Path to your oh-my-zsh installation.
export ZSH="/Users/cjp/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="dracula"

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

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

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

# plugins=(git)

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

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# fuzzy find
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vs code
export PATH="/usr/local/bin/code:$PATH"
alias codef="fzf | xargs code"