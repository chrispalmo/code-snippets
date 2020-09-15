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

alias who-is-using-my-connection="lsof -i tcp:{####}"
alias kill-the-process-using-my-connection="kill -9 {PID}" # kill PROCESS_WITH_PID using ####

# =====
# git
# =====

alias ghcp="o https://github.com/chrispalmo"

# standard aliases
alias ga='git add'
alias ga.='ga .'
alias gb='git branch' # list branches
alias gba='git branch -a' # list all branches
alias gc='git commit -a' # -a, --all: stage modified/deleted, but dont "ga."
alias gcp='git cherry-pick'
alias gca='git commit -a --amend ' # overwrite last commit
alias gcnv="git commit --no-verify"
alias gd='git diff'
alias gdn='git diff --name-only'
alias gds='gd --staged'
alias gdsn='gd --staged --name-only'
alias gl='git log'
alias gln='git log --name-only' # log includes list of files changed
alias glm='git log --merge' # list of commits that conflict during merge
alias go='git checkout' # switch branch
alias gob='git checkout -b' # create new branch, switch to it
alias gom='git checkout master'
alias gomu='git checkout master && git pull --rebase'
alias go-='git checkout -'
alias gp='git push'
alias gpu='git push --set-upstream origin' # use: gpu branch-name
alias grbi="git rebase --interactive" # use: `grbi [commit-hash-before-changes]. effect: Merge together all commits AFTER [commit-hash]. Refer: https://www.internalpointers.com/post/squash-commits-into-one-git. Use `git push --force origin [branch-name], but this isn't great... aim to avoid rebasing and squashing with by using git commit --amend in the first place.
alias gs='git status'
alias gsh='git show'
alias gst='git stash save' # `gst "message"` locally save uncommited changes (both staged and unstaged)
alias gsta='git stash apply' # apply stashed changes to working copy, without deleting from stash.
alias gstd='git stash drop' # delete a stash
alias gstk='git stash save --keep-index' # stash with message but keep index intact (like a periodic "progress save")
alias gstl='git stash list'
alias gstp='git stash pop' # remove stashed changes, reapply to working copy.
alias gr='git restore' # unstage all changes. use --hard to revert changed files.
alias gu='git pull --rebase'
alias git-undo-last-commit='git reset --soft HEAD~1'

# helpers
alias gcd='cd $(git rev-parse --show-toplevel)' # cd to repo root
alias gbn="git rev-parse --abbrev-ref HEAD" # return current branch name

# helper-assisted aliases
alias gpu='gbn | xargs git push --set-upstream origin'
alias gfiles='echo "$(git ls-files --others --exclude-standard ; git diff --name-only)"' # return list of modified files
alias gaf='gcd ; gfiles | fzf -m --height=8 | xargs git add ; cd -' # fzf-assisted git add
alias gof='gcd ; gfiles | fzf -m --height=8 | xargs git checkout ; cd -' # fzf-assisted git checkout
alias grf='gcd ; gfiles | fzf -m --height=8 | xargs git reset ; cd -' # fzf-assisted git checkout

# =====
# web
# =====

alias so='open https://stackoverflow.com/questions/ask'
