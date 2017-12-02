export PATH=$HOME/.cargo/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/share/npm/bin:/usr/local/bin:/usr/local/sbin:~/bin:$PATH

export PATH=/usr/local/bin/:usr/local/opt/coreutils/libexec/gnubin:/usr/local/sbin:/Users/oleg/.npm-packages/bin:/Users/oleg/.rvm/gems/ruby-2.2.1/bin:/Users/oleg/.rvm/gems/ruby-2.2.1@global/bin:/Users/oleg/.rvm/rubies/ruby-2.2.1/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/sbin:/Users/oleg/.npm-packages/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Users/oleg/.rvm/bin:/Users/oleg/.vimpkg/bin:$PATH

export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH/bin

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/opt/X11/lib/pkgconfig

# export GPG_TTY=$(tty)

# VIM 8
alias vi="nvim"

# brew
which brew &> /dev/null && . $(brew --prefix)/etc/bash_completion

set_prompts() {
    local black=""
    local blue=""
    local bold=""
    local cyan=""
    local green=""
    local orange=""
    local purple=""
    local red=""
    local reset=""
    local white=""
    local yellow=""
    local lightblue=""

    local hostStyle=""
    local userStyle=""

    local pre=""
    local post=""

    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        tput sgr0

        bold=$(tput bold)
        reset=$(tput sgr0)

        black=$(tput setaf 0)
        blue=$(tput setaf 33)
        cyan=$(tput setaf 37)
        green=$(tput setaf 64)
        orange=$(tput setaf 166)
        purple=$(tput setaf 125)
        red=$(tput setaf 124)
        white=$(tput setaf 15)
        yellow=$(tput setaf 136)
    else
        bold="\e[1mBold"
        reset="\e[0m"

        black="\e[1;30m"
        blue="\e[1;34m"
        cyan="\e[1;36m"
        green="\e[1;118m"
        orange="\e[1;33m"
        purple="\e[1;35m"
        red="\e[1;31m"
        white="\e[1;37m"
        yellow="\e[1;33m"
        lightblue="\e[1;34m"
    fi

    if [[ "$USER" == "root" ]]; then
        userStyle="\[$bold$red\]"
    else
        userStyle="\[$blue\]"
    fi

    if [[ "$SSH_TTY" ]]; then
        hostStyle="\[$bold$red\]"
    else
        hostStyle="\[$blue\]"
    fi

    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUNTRACKEDFILES=1
    GIT_PS1_SHOWUPSTREAM="auto verbose"
    GIT_PS1_SHOWCOLORHINTS=1

    pre="\[\033]0;\w\007\]"
    pre+="\n"
    pre+="\[$userStyle\]\u"
    pre+="\[$reset$blue\]@"
    pre+="\[$hostStyle\]\h"
    pre+="\[$reset$blue\]: "
    pre+="\[$cyan\]\w"
    pre+="\[$reset$red\]\[$reset\]"
    post="\n"
    post+="\[$reset$green\]😎  \[$reset\]"

    PROMPT_COMMAND="__git_ps1 '$pre' '$post' ' on %s'"
}

export EDITOR=nvim

set_prompts
unset set_prompts
set show-mode-in-prompt on

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# aliases
# alias ls='ls -la --color=auto'
alias dir='dir --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias zgrep='zgrep --color=auto'
alias zegrep='zegrep --color=auto'
alias zfgrep='zfgrep --color=auto'
alias diskspace="du -S | sort -n -r |more"

alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias cd..='cd ../'                         # Go back 1 directory level
alias ..='cd ../'                           # Go back 1 directory level
alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"
alias cdcode="cd ~/code"
alias serve='python -m SimpleHTTPServer'
alias psa="ps aux"
alias psg="ps aux | grep "
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

alias mygo="cd ~/code/go/src/github.com/olegakbarov"
alias rm_node_modules="find . -name 'node_modules' -exec rm -rf '{}' +"
alias v="mvim ."

# Git
gitgrep() { git logol "$1" | grep "$2" -i --color --context; }
deleteMerged() { git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d; }

# shortcuts for curl
curlput()  { curl -X PUT  -H "Content-Type: application/json" -d "$1" "$2"; }
curlpost() { curl -X POST -H "Content-Type: application/json" -d "$1" "$2"; }

cd() { builtin cd "$@"; ll; }               # Always list directory contents upon 'cd'
mkd() { mkdir -p "$1" && cd "$1"; }         # mcd: Makes new Dir and jumps inside

# searching
alias qfind="find . -name "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

ii () {
	echo -e "\nYou are logged on ${RED}$HOST"
	echo -e "\nAdditionnal information:$NC " ; uname -a
	echo -e "\n${RED}Users logged on:$NC " ; w -h
	echo -e "\n${RED}Current date :$NC " ; date
	echo -e "\n${RED}Machine stats :$NC " ; uptime
	echo -e "\n${RED}Current network location :$NC " ; scselect
	echo
}

httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }

onport() { lsof -i tcp:$1; }
encrypt () { hdiutil create -srcfolder $1 -encryption AES-128 $2; }

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                    # This loads nvm

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

