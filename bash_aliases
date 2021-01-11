# Git aliases
alias gs='git status'
alias gp='git push'
alias gb='git branch'

# Human-readable bytes formatting, binary and decimal numbering (2^10, 10^3)
alias humbytes='numfmt --to=iec-i --format %.2fB'
alias humbytes10='numfmt --to=si --format %.2fB'

# Calculator - use math library by default
alias bc='bc -l'

alias latexmk="latexmk -r $XDG_CONFIG_HOME/latexmkrc"

# Search the available pkg-conf packages using fzf
alias pkgs='pkgconf --list-all | fzf --tiebreak=begin'

# mkdir: --verbose --parent
alias mkdir='mkdir -pv'

alias diff='colordiff'

# Find TODOs and FIXMEs in files
# Usage: `$ todos <FILE GLOB(S)>`
# Or: `$ todos` to search cwd recursively
alias todos='grep -r "\(TODO\|FIXME\)"'

# Interactive when creating links
alias ln='ln -i'

# Human readable file sizes
alias du='du -h'
alias df='df -h'

# Ping aliases
# ping: give up after 5 dropped packets
alias ping='ping -c 5'
# fastping: quickly send packets
alias fastping='ping -c 100 -i.2'

# Word count lines
alias lc='wc -l'
llc() { [ -n "$1" ] && { ls -a "$1" | wc -l; } || { ls -a | wc -l; }; }

# Custom alerts
# low urgency
alias alertl='notify-send --urgency=low'
# normal urgency
alias alertn='notify-send --urgency=normal'
# critical urgency
alias alertc='notify-send --urgency=critical'

# Play video files
alias v='mpv'
alias vs='mpv --shuffle'

# Play video files in terminal as ASCII
alias vt='CACA_DRIVER=ncurses mpv -vo=caca --quiet'
alias vst='CACA_DRIVER=ncurses mpv -vo=caca --quiet --shuffle'

# Watch ~/Downloads/ contents
alias wdl='watch -t -n0.1 --color "ls ~/Downloads --color"'

# Watch sensor info
alias wsens='watch -t -n0.1 sensors'

function vlens () {
    find . -type f \( -iname "*.mp4" -o -iname "*.mkv" \) |
        tr '\n' '\0' |
        xargs -L1 -0 ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1
}

# Get video duration
alias vidlen='ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1'
alias vidlens='vlens'

# Get video information
alias vidinfo='ffprobe -v error -select_streams v -show_entries stream=width,height,r_frame_rate:format=duration -of default=noprint_wrappers=1 -sexagesimal'

alias sumvals='awk "{t+=\$1} END {printf \"%.8f\\n\", t}"'

alias sexagesimal='awk "{t=\$1; h=int(t/60/60); hs=60*60*h; m=int((t-hs)/60); ms=60*m; s=t-hs-ms; printf \"%d:%d:%.6f\\n\", h, m, s}"'


function confirm () {
    echo -e "PLEASE be extremely careful if you are using \e[7m\e[31mchmod\e[0m or \e[7m\e[31mchown\e[0m"
    echo -e "\e[1m\e[4m\e[33mSTRONGLY\e[0m consider if there may be unintended consequences"
    read -p "ARE YOU SURE? (y/n)" choice
    case "$choice" in
        y|Y ) return 1;;
        * ) return 0;;
    esac
}

alias rm='rm -I --preserve-root'
# Use absolute path /usr/bin/rm in scripts


alias vim="vim -i $XDG_CACHE_HOME/.viminfo"

alias tmux="tmux -f $XDG_CONFIG_HOME/tmux.conf"

alias stalonetray='stalonetray --config $XDG_CONFIG_HOME/stalonetrayrc'

alias shut='shutdown now'

# TODO: setup youtube-viewer with an API key so I can have personalised suggestions
alias YT='straw-viewer'

function hexd () {
    hexdump -C "$1" | less
}
alias hexdump='hexd'

alias words='cat /usr/share/dict/words'
alias scrabble='cat /usr/share/dict/scrabble'

alias unimatrix='unimatrix -a -f -s 96'

alias j='jobs -l'

alias w='curl v2.wttr.in'

alias yy='yay'
alias ys='yay -Ss'
alias yl='yay -Ql'

export GCALPATH="$XDG_CONFIG_HOME"/gcal
