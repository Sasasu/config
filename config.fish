set -gx SPACEFISH_KUBECONTEXT_SHOW false
set -gx fish_greeting ""
export PATH="$PATH:~/.gem/ruby/2.6.0/bin/"
export SSH_AUTH_SOCK=(gpgconf --list-dirs agent-ssh-socket)
export GPG_TTY=(tty)
