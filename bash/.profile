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

# Virtual environment deactivation
function deactivate_venv() {
    venv_active=$(which deactivate)
    if [[ $venv_active != *"deactivate not found"* ]]; then deactivate; fi
}

# List ids of all processes running on ports
# example usage: pids 8200 9229 4202 8080 6381
pids()
{
    lsof_output=""
    for port in $*; do
        lsof_output+=$(lsof -i :$port)
    done
    # process ids are 1 or more (typically 4-5) digits surrounded by spaces
    process_ids=$(echo $lsof_output | perl -ne 'print  if s/.*( \d+ ).*/\1/')
    echo $process_ids
}

# clean up memory leaks caused by cc-stack
alias csls='pids 8200 9229 4202 8080 6381'
alias cskill='csls | xargs kill'

# =====
# web
# =====

alias gg=google
alias es=explainshell
alias soa='open https://stackoverflow.com/questions/ask'
alias sos=stackoverflow

# =====
# Misc
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
alias o.='open .'
alias of='fzf | xargs code'
alias cf="fzf | cd"

alias trash='safe_rm'
alias grep='grep -H -n'
alias cwd='pwd | tr -d "\r\n" | pbcopy' #copy working directory
alias h='history'
alias ppath="echo $PATH | tr ':' '\n'" #print path
alias :q="exit"

alias copy="tr -d '\n' | pbcopy" # remove carriage return at the end of pbcopy on a mac.
alias d="deactivate"

alias checkport='lsof -i :<port>' # reminder only
alias killprocess'kill <process#>' # reminder only

# =====
# git
# =====

alias ghcp="o https://github.com/chrispalmo"

# standards
alias ga='git add'
alias gb='git branch' # list branches
alias gba='git branch -a' # list all branches
alias gbd="git branch --delete"
alias gbdr="git push origin --delete" # delete remote branch. use: gbdr [branch-name]
alias gcnv='git commit --no-verify'
alias gcp='git cherry-pick'
alias gc='git commit'
alias gca='git commit --amend ' # overwrite last commit
alias gcnv="git commit --no-verify"
alias gd='git diff'
alias gdn='git diff --name-only'
alias gds='git diff --staged'
alias gdsn='gd --staged --name-only'
alias gl='git log'
alias glf='git log --name-only' # log includes list of files changed
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
alias gr1c='git reset HEAD^' # reset to state before last commit, keeping changes
alias gr='git reset'
alias grh='git reset --hard'
alias grbi="git rebase --interactive" # use: `grbi [commit-hash-before-changes]. effect: Merge together all commits AFTER [commit-hash]. Refer: https://www.internalpointers.com/post/squash-commits-into-one-git. Use `git push --force origin [branch-name], but this isn't great... aim to avoid rebasing and squashing with by using git commit --amend in the first place.
alias gs='git status'
alias gsh='git show'
alias gshn='git show --name-only' # list files changed in latest commit
alias gst='git stash save' # `gst "message"` locally save uncommited changes (both staged and unstaged)
alias gsta='git stash apply' # apply stashed changes to working copy, without deleting from stash.
alias gstd='git stash drop' # delete a stash
alias gstk='git stash save --keep-index' # keeps staged changes and stashes un-tracked changes
alias gstl="git stash list"
alias gstls="git stash list --stat" # list files changed for each stash
alias gstp='git stash pop' # delete stash; apply stashed changes to working copy
alias gu='git pull --rebase'
alias git-undo-last-commit='git reset --soft HEAD~1'
alias git-undo-reset='git reset ORIG_HEAD'

# helpers
alias fzf8="fzf -m --height=8"
function gcm () { [[ $@ != '' ]] && { COMMIT_MESSAGE="$@" ; git commit -m $COMMIT_MESSAGE } || git commit }
alias gcd='cd $(git rev-parse --show-toplevel)' # cd to repo root
alias gbn="git rev-parse --abbrev-ref HEAD" # return current branch name
alias gfiles='echo "$(git ls-files --others --exclude-standard ; git diff --name-only; git diff --staged --name-only)"' # list modified files
alias gbranches='git for-each-ref --format="%(refname:short)" refs/' # list all branches
alias gbranches_raw='{branches=$(gbranches); echo ${branches//origin\/};}' # list all branches, sans 'origin/' prefic

# helper-assisted
alias ga.='gcd; ga .; cd -'
alias gbc='{CURRENT_BRANCH=$(gbn); CURRENT_REPO=$(cut -d . -f 1 <<< $(cut -d : -f 2 <<< $(git config --get remote.origin.url))); o https://github.com/"$CURRENT_REPO"/compare/"$CURRENT_BRANCH";}' # compare current branch to master on github website
alias gbnc='gbn | copy'
alias gpu='gbn | xargs git push --set-upstream origin'
function gacp() { ga. ; gcm "$@" ; gp }
function gacpc() { ga. ; gcm "$@" ; gp ; gbc }
function gacpu() { ga. ; gcm "$@" ; gpu }
function gacpuc() { ga. ; gcm "$@" ; gpu ; gbc }

# helper-assisted (using fuzzy-find)
alias gaf='gcd ; gfiles | fzf8 | xargs git add ; cd -' # fzf-assisted git add
alias gbdf='gcd ; gbranches_raw | fzf8 | xargs git branch --delete' # fzf-assisted git delete branch
alias gbdrf='gcd ; gbranches_raw | fzf8 | xargs git push origin --delete' # fzf-assisted git delete remote branch
alias gdf='gcd ; gfiles | fzf8 | xargs git diff ; cd -' # fzf-assisted git diff
alias gdsf='gcd ; gfiles | fzf8 | xargs git diff --staged ; cd -' # fzf-assisted git diff
alias gof='gcd ; gfiles | fzf8 | xargs git checkout ; cd -' # fzf-assisted git checkout
alias gobf='gbranches_raw | fzf8 | xargs git checkout' # fzf-assisted git checkout branch

# github.com CLI
alias ghprv='gh pr view --web'
alias ghprc='gh pr create --fill ; git pr view --web'