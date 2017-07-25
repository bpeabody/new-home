export EDITOR="vim"
export HISTSIZE=100000
export HISTFILESIZE=100000
export GIT_SSL_NO_VERIFY=1

export PS1='\!:\W$ '
export PROMPT_COMMAND='history -a'
export PATH=~/bin:$PATH

shopt -s cdspell

set -o vi

shopt -s checkwinsize
shopt -s histappend

stty -ixon

alias more=less
