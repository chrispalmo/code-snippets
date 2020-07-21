# increase history limit (100KB or 5K entries)
export HISTFILESIZE=100000
export HISTSIZE=5000
export HISTCONTROL=ignoredups #Don't put duplicate lines in your bash history

# Safe rm procedure
safe_rm()
{
    # Cycle through each argument for deletion
    for file in $*; do
        if [ -e $file ]; then
            # Target exists and can be moved to Trash safely
            if [ ! -e ~/.Trash/$file ]; then
                mv $file ~/.Trash
            # Target exists and conflicts with target in Trash
            elif [ -e ~/.Trash/$file ]; then
                # Increment target name until 
                # there is no longer a conflict
                i=1
                while [ -e ~/.Trash/$file.$i ];
                do
                    i=$(($i + 1))
                done
                # Move to the Trash with non-conflicting name
                mv $file ~/.Trash/$file.$i
            fi
        # Target doesn't exist, return error
        else
            echo "rm: $file: No such file or directory";
        fi
    done
}

# Google it
google() {
    search=""
    echo "Googling: $@"
    for term in $@; do
        search="$search%20$term"
    done
    open "http://www.google.com/search?q=$search"
}

# Search explainshell
explainshell() {
    search=""
    echo "Searching explainshell: $@"
    for term in $@; do
        search="$search+$term"
    done
    open "https://explainshell.com/explain?cmd=$search"
}

# Make new directory and navitgate into it
function mcd() { mkdir -p $1 && cd $1 }

# =====
# OSX
# =====

alias gi=google
alias es=explainshell

alias ll='pwd && ls -l'
alias la='pwd && ls -lA'
alias l='ls -hpCF'
alias cll="clear; ls -lAh"
alias cp='cp -i'
alias mv='mv -i'

alias ..="cd .."
alias ..2="cd ../../"
alias ..3="cd ../../../"
alias b='cd -'
alias ~='cd ~'
alias o='open'

alias bp="~/dev/code-snippets/bash/"
alias trash='safe_rm'
alias grep='grep -H -n'
alias cwd='pwd | tr -d "\r\n" | pbcopy' #copy working directory
alias h='history'
alias ppath="echo $PATH | tr ':' '\n'" #print path
alias :q="exit"

# =====
# Git
# =====

alias ga='git add'
alias gcd='cd $(git rev-parse --show-toplevel)'
alias gfiles='echo "$(git ls-files --others --exclude-standard ; git diff --name-only)"'
alias gaf='gcd ; gfiles | fzf -m --height=8 | xargs git add ; cd -'
alias gap='ga -p'
alias gapf='FILE=$(gfiles | fzf --height=8) && gap $FILE'
alias ga.='ga .'
alias ga.ds='ga . && gds'
alias ga.st='ga . && gst'
alias gb='git branch'
alias gbdm='gb --merged | grep -v "\(^\*\)\|\(^  master$\)" | xargs git branch -d'
alias gbn='git rev-parse --abbrev-ref HEAD'
alias gc='git commit'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gds='gd --staged'
alias gf='git fetch'
alias gl='git log'
alias gm='git merge'
alias gmm='gm master'
alias go='git checkout'
alias gob='git checkout -b'
alias gof='gcd ; git diff --name-only | fzf --height=8 | xargs git checkout ; cd -'
alias gom='git checkout master'
alias gop='git checkout -'
alias gomu='gom && gu'
alias gomup='gom && gu && gop'
alias gp='git push'
alias gpu='gbn | xargs git push --set-upstream origin'
alias gr='git reset'
alias grf='gcd ; git diff --staged --name-only | fzf -m --height=8 | xargs git reset ; cd -'
alias grmf='gcd ; git diff --name-only --diff-filter=U | fzf -m --height=8 | xargs git rm ; cd -'
alias gs='git status'
alias gst='git stash'
alias gsts='git stash save'
alias gstk='git stash save --keep-index'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gu='git pull --rebase'
