export EDITOR="nvim"
export HISTSIZE=100000
export HISTFILESIZE=100000
export GIT_SSL_NO_VERIFY=1

export PS1="\[\e[32m\]\h\[\e[m\]:\[\e[36m\]\w\[\e[m\]$ "
export PROMPT_COMMAND='history -a'
export PATH=~/local/bin:~/bin:$PATH
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

shopt -s cdspell

set -o vi

shopt -s checkwinsize
shopt -s histappend

stty -ixon

alias more=less
alias tmux="tmux -2"  # needed to get tmux to allow 256 colors

export DISPLAY=:0.0

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export OPEN_API_KEY=$(cat ~/keys/ChatGPT.nvim.openai)
