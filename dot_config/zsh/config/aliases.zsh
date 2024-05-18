alias mkdir="${aliases[mkdir]:-mkdir} -pv"

# Default to safe options
alias cp="${aliases[cp]:-cp} -iv"
alias ln="${aliases[ln]:-ln} -iv"
alias mv="${aliases[mv]:-mv} -iv"
alias rm="${aliases[rm]:-rm} -i"
alias chown="${aliases[chown]:-chown} --preserve-root"
alias chmod="${aliases[chmod]:-chmod} --preserve-root"
alias chgrp="${aliases[chgrp]:-chgrp} --preserve-root"

# Various ls convenience aliases
alias ls="${aliases[ls]:-ls} -hF --color=auto"
alias lr='ls -R'
alias ll="eza -l --all --group-directories-first"
alias la='ll -A'
alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
alias lm='la | more'
alias lsdot="ls -a --ignore='[^.]*'"


alias grep='grep --color=auto'

alias wget='wget --hsts-file="${XDG_CACHE_HOME:-$HOME/.cache}"/wget-hsts'
alias xbindkeys='xbindkeys -f "${XDG_CONFIG_HOME:-$HOME/.config}"/xbindkeys/config'

# PRIME render offloading support (https://download.nvidia.com/XFree86/Linux-x86_64/435.17/README/primerenderoffload.html)
alias vkr="__NV_PRIME_RENDER_OFFLOAD=1"
alias nvr="__NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia"

alias df='df -kh'
alias du='du -kh'

# Easy download alias, prioritized by command availability
if (( ${+commands[aria2c]} )); then
  alias get='aria2c --max-connection-per-server=5 --continue'
elif (( ${+commands[axel]} )); then
  alias get='axel --num-connections=5 --alternate'
elif (( ${+commands[wget]} )); then
  alias get='wget --continue --progress=bar --timestamping'
elif (( ${+commands[curl]} )); then
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
fi

# Guard against disastrous permission changes
if [[ "$(uname)" == linux* ]]; then
  alias chmod='chmod --preserve-root -v'
  alias chown='chown --preserve-root -v'
fi

# Git
alias gsu="git submodule update --recursive --remote"
