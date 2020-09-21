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

# web search
function google() {
    open -na "Google Chrome" --args "https://www.google.com/search?q=$*"
}
function stackoverflow() {
    open -na "Google Chrome" --args "https://www.google.com/search?q=site:stackoverflow.com $*"
}
function explainshell() {
    open -na "Google Chrome" --args "https://explainshell.com/explain?cmd=$*"
}

# Make new directory and navitgate into it
function mcd() { mkdir -p $1 && cd $1 }

# =====
# web
# =====

alias gg=google
alias es=explainshell
alias soa='open https://stackoverflow.com/questions/ask'
alias sos=stackoverflow

# =====
# OSX
# =====

alias ll='pwd && ls -l'
alias la='pwd && ls -lA'
alias l='ls -hpCF'
alias cll="clear; ls -lAh"
alias cp='cp -i'
alias mv='mv -i'
alias x='xargs'

alias ..="cd .."
alias ..2="cd ../../"
alias ..3="cd ../../../"
alias b='cd -'
alias ~='cd ~'
alias o='open'
alias of='fzf | xargs code'

alias trash='safe_rm'
alias grep='grep -H -n'
alias cwd='pwd | tr -d "\r\n" | pbcopy' #copy working directory
alias h='history'
alias ppath="echo $PATH | tr ':' '\n'" #print path
alias :q="exit"

alias copy="tr -d '\n' | pbcopy" # remove carriage return at the end of pbcopy on a mac.

# =====
# git
# =====

alias ghcp="o https://github.com/chrispalmo"

# standard aliases
alias ga='git add'
alias ga.='ga .'
alias gb='git branch' # list branches
alias gba='git branch -a' # list all branches
alias gbd="git branch --delete"
alias gc='git commit'
alias gcnv='git commit --no-verify'
alias gcp='git cherry-pick'
alias gca='git commit --amend ' # overwrite last commit
alias gcnv="git commit --no-verify"
alias gd='git diff'
alias gdn='git diff --name-only'
alias gds='git diff --staged'
alias gdsn='gd --staged --name-only'
alias gl='git log'
alias gln='git log --name-only' # log includes list of files changed
alias glm='git log --merge' # list of commits that conflict during merge
alias gm='git merge'
alias gmm='git merge master'
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
alias gstk='git stash save --keep-index' # keeps staged changes and stashes un-tracked changes
alias gstl="git stash list"
alias gstls="git stash list --stat" # list files changed for each stash
alias gstp='git stash pop' # delete stash; apply stashed changes to working copy
alias gu='git pull --rebase'
alias git-undo-last-commit='git reset --soft HEAD~1'

# helpers
alias fzf8="fzf -m --height=8"
alias gcd='cd $(git rev-parse --show-toplevel)' # cd to repo root
alias gbn="git rev-parse --abbrev-ref HEAD" # return current branch name
alias gfiles='echo "$(git ls-files --others --exclude-standard ; git diff --name-only; git diff --staged --name-only)"' # list modified files
alias gbranches='git for-each-ref --format="%(refname:short)" refs/' # list all branches
alias gbranches_raw='{branches=$(gbranches); echo ${branches//origin\/};}' # list all branches, sans 'origin/' prefic

# helper-assisted aliases
alias gpu='gbn | xargs git push --set-upstream origin'
# helper-assisted aliases (using fuzzy-find)
alias gaf='gcd ; gfiles | fzf8 | xargs git add ; cd -' # fzf-assisted git add
alias gbdf='gcd ; gbranches_raw | fzf8 | xargs git branch --delete' # fzf-assisted git delete branch
alias gdf='gcd ; gfiles | fzf8 | xargs git diff ; cd -' # fzf-assisted git diff
alias gdsf='gcd ; gfiles | fzf8 | xargs git diff --staged ; cd -' # fzf-assisted git diff
alias gof='gcd ; gfiles | fzf8 | xargs git checkout ; cd -' # fzf-assisted git checkout
alias gobf='gbranches_raw | fzf8 | xargs git checkout' # fzf-assisted git checkout branch
