set -gx SPACEFISH_KUBECONTEXT_SHOW false
set -gx fish_greeting ""

if test "$(uname -o)" = "Darwin"
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/opt/homebrew/sbin:$PATH"
    export PATH="/usr/local/bin:$PATH"
    export PATH="$HOME/.cargo/bin:$PATH"
end

export PATH="~/.local/bin/:$PATH"
export PATH="~/.cargo/bin/:$PATH"

export SSH_AUTH_SOCK=(gpgconf --list-dirs agent-ssh-socket)
export GPG_TTY=(tty)
gpgconf --launch gpg-agent

export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US:en_US

alias ls exa
alias gitc "git commit -s"
alias make "make -j8"
alias ag "rg"
alias k "kubectl"
alias codexbc "proxychains4 -q -f ~/.cursor/proxychains-agent.conf /usr/bin/codex -p bc"


if test -z $TMUX && test -z $SSH_CONNECTION && which tmux >/dev/null 2>&1
  exec tmux
end

function python_to_3
    sudo rm /usr/bin/python
    sudo ln -s /usr/bin/python3 /usr/bin/python
end

function python_to_2
    sudo rm /usr/bin/python
    sudo ln -s /usr/bin/python2 /usr/bin/python
end

alias pp "ps aux | grep postgres | grep -v grep | grep -P '\d'"
alias ppc "ps aux | grep postgres | grep -v grep | grep con | grep -P '\d'"

#export JAVA_HOME=/usr/lib/jvm/default-runtime
starship init fish | source

export EDITOR=/usr/bin/nvim

starship init fish | source



function __direnv_export_eval --on-event fish_prompt;
    "/usr/bin/direnv" export fish | source;

    if test "$direnv_fish_mode" != "disable_arrow";
        function __direnv_cd_hook --on-variable PWD;
            if test "$direnv_fish_mode" = "eval_after_arrow";
                set -g __direnv_export_again 0;
            else;
                "/usr/bin/direnv" export fish | source;
            end;
        end;
    end;
end;

function __direnv_export_eval_2 --on-event fish_preexec;
    if set -q __direnv_export_again;
        set -e __direnv_export_again;
        "/usr/bin/direnv" export fish | source;
        echo;
    end;

    functions --erase __direnv_cd_hook;
end;

set -gx NO_PROXY "127.0.0.1,localhost,::1"
set -gx no_proxy "127.0.0.1,localhost,::1"
