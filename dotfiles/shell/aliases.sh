# Bash
alias aliases="alias | sed 's/=.*//'"
alias functions="declare -f | grep '^[a-z].* ()' | sed 's/{$//'"
alias paths='echo -e ${PATH//:/\\n}'
alias reload="source ~/.bash_profile"

# Colored
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# Directories
## cd
alias cd..="cd .."
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
## ls - https://github.com/ogham/exa
alias l="exa -h --git"
alias ls="exa -h --git"
alias la="exa -ah --git"
alias ll="exa -ahl --git"

# Files
## Confirmations
alias cp="cp -riv"
alias ln="ln -iv"
alias mv="mv -iv"
## Editors - https://github.com/sharkdp/bat
alias bat="batcat"
alias cat="batcat"
alias nano="nano -c"
## Safety
alias chgrp="chgrp --preserve-root"
alias chmod="chmod --preserve-root"
alias chown="chown --preserve-root"
alias rm="rm -I --preserve-root"
## tokei - https://github.com/XAMPPRocky/tokei
alias tokei="tokei --hidden"

# Internet
alias hosts="sudo $EDITOR /etc/hosts"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias nmap="sudo -E nmap"
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias wget="wget -c"
## Ping
alias ping="ping -c 5"
alias fastping="ping -c 100 -s 2"

# Node
alias npkill="npx npkill ."
alias twconf="npx tailwind-config-viewer -o"

# System
alias halt="sudo /sbin/halt"
alias please='sudo "$BASH" -c "$(history -p !!)"'
alias poweroff="sudo /sbin/poweroff"
alias reboot="sudo /sbin/reboot"
alias shutdown="sudo /sbin/shutdown"
## Status
### bottom - https://github.com/ClementTsang/bottom
alias htop="btm"
alias top="btm"

### CPU
alias cpuinfo="lscpu"
if [ -f /sys/class/thermal/thermal_zone0/temp ]; then
  alias cputemp="echo $(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))ºC"
fi
alias pscpu="ps auxf | sort -nr -k 3"
alias pscpu10="ps auxf | sort -nr -k 3 | head -10"
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
