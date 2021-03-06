set -gx SPACEFISH_KUBECONTEXT_SHOW false
set -gx fish_greeting ""
export PATH="$PATH:~/.local/bin/"
export SSH_AUTH_SOCK=(gpgconf --list-dirs agent-ssh-socket)
export GPG_TTY=(tty)

alias ls exa
alias gitc "git commit -s"

if test -z $TMUX && test -z $SSH_CONNECTION && which tmux >/dev/null 2>&1
  exec tmux
end

alias pp "ps aux | grep postgres | grep -v grep | grep -P '\d'"

function python_to_3
    sudo rm /usr/bin/python
    sudo ln -s /usr/bin/python3 /usr/bin/python
end

function python_to_2
    sudo rm /usr/bin/python
    sudo ln -s /usr/bin/python2 /usr/bin/python
end

alias pp "ps aux | grep postgres | grep -v grep | grep -P '\d'"

starship init fish | source
