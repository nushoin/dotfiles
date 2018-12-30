alias ll='ls -lFh'

case "$OSTYPE" in
  linux*)
    echo "Linux / WSL"
    [[ -e ~/.bash_custom_linux ]] && source ~/.bash_custom_linux
    ;;
  darwin*)
    echo "Mac OS X"
    [[ -e ~/.bash_custom_mac ]] && source ~/.bash_custom_mac
    ;;
  win*)     echo "Windows" ;;
  msys*)    echo "MSYS / MinGW / Git Bash" ;;
  cygwin*)  echo "Cygwin" ;;
  bsd*)     echo "BSD" ;;
  solaris*) echo "Solaris" ;;
  *)        echo "unknown: $OSTYPE" ;;
esac

# disable flow control (Ctrl-q/Ctrl-s)
stty -ixon

# add git info to the prompt
PS1='${debian_chroot:+($debian_chroot) }\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[38;5;95m\]$(__git_ps1)\[\033[0m\]\$ '

[[ -e ~/.bash_aliases.$USER ]] && source ~/.bash_aliases.$USER
