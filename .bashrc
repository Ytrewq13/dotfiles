#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# shellcheck source=/home/sam/.dotfiles/xdgdirs

# TODO: move dotfiles directory out of home dir (put it in ~/.config ?)
export DOTFILES="$HOME/.dotfiles"
[ -f "$DOTFILES/xdgdirs" ] && . "$DOTFILES/xdgdirs"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
force_color_prompt=

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    # FIXME
    #test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    if test -r ~/.dircolors
    then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
    # FIXME END
    alias ls='exa --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='exa -aalF'
alias la='exa -a'
alias l='exa -F'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
# FIXME
#   elif [ -f /etc/bash_completion ]; then
#       . /etc/bash_completion
# FIXME END
    fi
fi


######################
######################
## Home dir cleanup ##
######################
######################

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f "$HOME"/.config/bash/bash_aliases ]; then
    # shellcheck source=/dev/null
    . "$HOME"/.config/bash/bash_aliases
fi


# Bash completion config file
export BASH_COMPLETION_USER_FILE="$XDG_CONFIG_HOME"/bash-completion/bash_completion

# Bash history file
export HISTFILE="$XDG_DATA_HOME"/bash/history

# Rust's cargo data
export CARGO_HOME="$XDG_DATA_HOME"/cargo

# GNU's gpg2 data
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
alias gpg2='gpg2 --homedir "$XDG_DATA_HOME"/gnupg'

# Less' history file (why does this exist & why am I keeping it?)
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history

# Haskell's stack data
export STACK_ROOT="$XDG_DATA_HOME"/stack

# Subversion (not even installed, why does it's dir exist?)
alias svn='svn --config-dir "$XDG_CONFIG_HOME"/subversion'

# Ruby Gems data
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem

# Mutt email client
alias neomutt='neomutt -F "$XDG_CONFIG_HOME"/mutt/.muttrc'
alias mutt='neomutt'

# Github CLI completion
eval "$(gh completion -s bash)"

#####################################################################
########################## nnn file browser #########################
#####################################################################

n ()
{
    # Block nesting of nnn in subshells
    if [ -n "$NNNLVL" ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn -e -E "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            # shellcheck source=/dev/null
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

#################
## NNN Bookmarks:
#################
# u: Uni group project git repo top level
export NNN_BMS="u:~/Documents/uni_stuff/2/CPP"
# w: wallpapers
export NNN_BMS="w:~/Pictures/desktop-backgrounds;$NNN_BMS"
# D: downloads
export NNN_BMS="D:~/Downloads;$NNN_BMS"
# d: documents
export NNN_BMS="d:~/Documents;$NNN_BMS"
# c: config (dotfiles)
export NNN_BMS="c:$DOTFILES;$NNN_BMS"
# h: home
export NNN_BMS="h:~;$NNN_BMS"

#####################################################################
########################### Misc  stuff #############################
#####################################################################

# Allow typing a directory path to cd (no need to type `cd`).
shopt -s autocd

# Automatically ls (using `$ exa`) after calling cd (only if the wd changes).
__new_wd=
PROMPT_COMMAND='[[ ${__new_wd:=$PWD} != $PWD ]] && exa; __new_wd=$PWD'

export MAKEFLAGS="-j$(( "$(nproc)" + 1 ))"


export BIBINPUTS="$BIBINPUTS:${HOME}/bib/"

export PATH="$HOME/.scripts:$HOME/.local/bin:/mybin:$PATH"

#neofetch
# shellcheck source=/dev/null
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

eval "$(starship init bash)"

source /usr/share/fzf/completion.bash
source /usr/share/fzf/key-bindings.bash


__fzf_rg__() {
    RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
    FZF_DEFAULT_COMMAND="$RG_PREFIX ''" fzf --bind "change:reload:$RG_PREFIX {q} || true" --ansi --disabled | while read -r item; do
        printf '%q ' "$item"
    done
    echo
}
# CTRL-G - Grep over files under the current working directory
bind -m emacs-standard -x '"\C-g": __fzf_rg__'
bind -m vi-command -x '"\C-g": __fzf_rg__'
bind -m vi-insert -x '"\C-g": __fzf_rg__'

# shellcheck disable=2016
bind -x '"\C-p": vim $(fzf);'
