alias ll='ls -lFh'
lls() { ll --group-directories-first --color=always $*|less -SR; }

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

# disable duplicates in history
export HISTCONTROL=ignoreboth:erasedups

# save history on exit
# function historymerge {
#   history -r; history -w;
# }
# trap historymerge EXIT

# read history when showing the prompt
# PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# add git info to the prompt
PS1='${debian_chroot:+($debian_chroot) }\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[38;5;95m\]$(__git_ps1)\[\033[0m\]\$ '

export PATH=$PATH:~/.cargo/bin:$HOME/.local/bin

[[ -e ~/.bash_aliases.$USER ]] && source ~/.bash_aliases.$USER
