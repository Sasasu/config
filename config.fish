set -gx SPACEFISH_KUBECONTEXT_SHOW false
set -gx fish_greeting ""
export SSH_AUTH_SOCK=(gpgconf --list-dirs agent-ssh-socket)
export GPG_TTY=(tty)
