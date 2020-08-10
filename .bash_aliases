# Git aliases
alias gs='git status'
alias gp='git push'
alias gb='git branch'

# Calculator - use math library by default
alias bc='bc -l'

# mkdir: --verbose --parent
alias mkdir='mkdir -pv'

alias diff='colordiff'

# Interactive when creating links
alias ln='ln -i'

# Human readable file sizes
alias du='du -h'

# Ping aliases
# ping: give up after 5 dropped packets
alias ping='ping -c 5'
# fastping: quickly send packets
alias fastping='ping -c 100 -i.2'

# Word count lines
alias lc='wc -l'

# Play video files
alias v='mpv --volume=40'
alias vs='mpv --volume=40 --shuffle'

# Get video duration
alias vidlen='ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 -sexagesimal'


function confirm () {
    echo -e "PLEASE be extremely careful if you are using \e[7m\e[31mchmod\e[0m or \e[7m\e[31mchown\e[0m"
    echo -e "\e[1m\e[4m\e[33mSTRONGLY\e[0m consider if there may be unintended consequences"
    read -p "ARE YOU SURE? (y/n)" choice
    case "$choice" in
        y|Y ) return 1;;
        * ) return 0;;
    esac
}
alias sudo='confirm || sudo '

alias rm='rm -I --preserve-root'
# Use absolute path /usr/bin/rm in scripts


# TODO: move dotfiles directory out of home dir (put it in ~/.config ?)
alias vim='vim -u ~/dotfiles/.vimrc'

alias shut='shutdown now'

# TODO: setup youtube-viewer with an API key so I can have personalised suggestions
alias YT='straw-viewer'

alias hexdump='hexdump -C'

alias words='cat /usr/share/dict/words'
alias scrabble='cat /usr/share/dict/scrabble'

alias unimatrix='unimatrix -a -f -s 96'

alias j='jobs -l'

alias w='curl v2.wttr.in'

alias yy='yay'
alias ys='yay -Ss'
alias yl='yay -Ql'

export GCALPATH="$XDG_CONFIG_HOME"/gcal
