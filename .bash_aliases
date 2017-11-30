alias ll='ls -lFh'
export TERM=xterm
export EDITOR=vim
stty -ixon
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[38;5;95m\]$(__git_ps1)\[\033[0m\]\$ '

