set -gx SPACEFISH_KUBECONTEXT_SHOW false
set -gx fish_greeting ""
export PATH="$PATH:~/.local/bin/"
export SSH_AUTH_SOCK=(gpgconf --list-dirs agent-ssh-socket)
export GPG_TTY=(tty)

alias ls exa
alias gitc "git commit -s"

# TMUX
if which tmux >/dev/null 2>&1
    # if no session is started, start a new session
    test -z $TMUX && exec tmux

    # when quitting tmux, try to attach
    while test -z $TMUX
        tmux attach || break
    end
end

function force_python2
    set PATH "/opt/Python2:$PATH"
end

starship init fish | source
