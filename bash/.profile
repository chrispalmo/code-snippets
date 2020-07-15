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

# =====
#  OSX
# =====

alias gg=google
alias es=explainshell

alias ll='echo && pwd && ls -l'
alias la='echo && pwd && ls -lA'
alias l='echo && ls -hpCF'
alias cll="clear; ls -lAh"
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
