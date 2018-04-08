alias ll='ls -lFh'

# only set the following when inside a chroot
if [[ "$debian_chroot" == "chroot" ]]; then
    export TERM=xterm
    export EDITOR=vim
fi

# disable flow control (Ctrl-q/Ctrl-s)
stty -ixon

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[38;5;95m\]$(__git_ps1)\[\033[0m\]\$ '

source .bash_aliases.$USER
