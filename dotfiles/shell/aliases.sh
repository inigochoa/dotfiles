# Bash
alias copy="xclip -selection clipboard"
alias functions="declare -f | grep '^[a-z].* ()' | sed 's/{$//'"
alias histstats="history | awk '{CMD[\$2]++;count++;}END { for (a in CMD)print CMD[a] \" \" CMD[a]/count*100 \"% \" a;}' | grep -v './' | column -c3 -s ' ' -t | sort -nr | nl |  head -n10"
alias parrot="curl parrot.live"
alias paste="xclip -selection clipboard -o"
alias paths='echo -e ${PATH//:/\\n}'
alias rates="curl rate.sx"
alias reload="source ~/.bash_profile"
alias rr="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"
alias ssup='sh -c "$(curl -fsSL https://starship.rs/install.sh)"'
alias weather="wttr"
alias :q="exit"

# Colored
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias grep="grep --color=auto"

# Directories
## cd
alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."
## ls - https://github.com/ogham/exa
if [ -f ~/.cargo/bin/exa ]; then
  alias exa="exa --color=always --group-directories-first"
  alias l="exa"
  alias la="l -a"
  alias ll="la -hl --git"
  alias ls="l"
  alias lt="la -T"
  alias lt2="lt --level=2"
  alias lt3="lt --level=3"
  alias lt4="lt --level=4"
  alias lt5="lt --level=5"
  alias l.="la | egrep '^\.'"
else
  alias ls='ls --color=auto'
  alias ll='ls -alF'
  alias la='ls -A'
  alias l='ls -CF'
fi
## tree - https://github.com/solidiquis/erdtree
alias tree="et"

# Files
## Confirmations
alias cp="cp -riv"
alias ln="ln -iv"
alias mv="mv -iv"
## Editors - https://github.com/sharkdp/bat
if [ -f /usr/bin/batcat ]; then
  alias cat="batcat"

  if [ -f /usr/local/bin/batman ]; then
    alias man='batman'
  else
    export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
  fi
fi
alias nano="nano -c"
## Safety
alias chgrp="chgrp --preserve-root"
alias chmod="chmod --preserve-root"
alias chown="chown --preserve-root"
alias rm="rm -I --preserve-root"
## tokei - https://github.com/XAMPPRocky/tokei
if [ -f ~/.cargo/bin/tokei ]; then
  alias tokei="tokei --hidden"
fi

# git-cliff - https://github.com/orhun/git-cliff
alias gitcliff="git-cliff --config ~/.cliff.toml --output CHANGELOG.md --unreleased"

# Internet
alias hosts="sudo $EDITOR /etc/hosts"
alias ip="curl ifconfig.co/"
alias nmap="sudo -E nmap"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias wget="wget -c"
## Ping
alias ping="ping -c 5"
alias fastping="ping -c 100 -s 2"

# Node
alias card="npx inigochoa"
alias npkill="npx npkill ."
alias serve="npx light-server -w \"*\" -s"
alias twconf="npx tailwind-config-viewer -o"

# System
alias halt="sudo /sbin/halt"
alias please='sudo "$BASH" -c "$(history -p !!)"'
alias poweroff="sudo /sbin/poweroff"
alias reboot="sudo /sbin/reboot"
alias shutdown="sudo /sbin/shutdown"
if [ -f /usr/bin/nitrogen ] && [ -d "$HOME/.local/share/backgrounds" ]; then
  alias wallpaper="nitrogen --save --set-auto --random $HOME/.local/share/backgrounds"
fi
## Status
### bottom - https://github.com/ClementTsang/bottom
if [ -f ~/.cargo/bin/btm ]; then
  alias htop="btm"
  alias top="btm"
fi
### CPU
alias cpuinfo="lscpu"
if [ -f /sys/class/thermal/thermal_zone0/temp ]; then
  alias cputemp="echo $(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))ºC"
fi
alias pscpu="ps auxf | sort -nr -k 3"
alias pscpu10="ps auxf | sort -nr -k 3 | head -10"
### fetch-master 6000 - https://github.com/anhsirk0/fetch-master-6000
if [ -f ~/.local/bin/fm6000 ] || [ -f /usr/local/bin/fm6000 ]; then
  alias fm6000="fm6000 -r -c bright_blue"
  alias neofetch="fm6000"
fi
### Memory
alias df="df -H"
alias du="du -ch"
alias du1="du --max-depth=1 | sort -h"
alias du2="du --max-depth=2 | sort -h"
alias meminfo="free -m -l -t"
alias psmem="ps auxf | sort -nr -k 4"
alias psmem10="ps auxf | sort -nr -k 4 | head -10"
if [ -f /var/log/Xorg.0.log ]; then
  alias gpumeminfo="grep -i --color memory /var/log/Xorg.0.log"
fi
## Updates
alias u="sudo apt update"
alias uu="u && sudo apt upgrade -y"
alias uua="uu && sudo apt autoremove -y"

# Time
alias now="date +'%T'"
alias nowdate="date +'%d-%m-%Y'"
## Add an "alert" alias for long running commands:
##   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
