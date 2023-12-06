# Colors for less
if [[ ${PAGER} == 'less' ]]; then
  (( ! ${+LESS_TERMCAP_mb} )) && export LESS_TERMCAP_mb=$'\E[1;31m'   # Begins blinking.
  (( ! ${+LESS_TERMCAP_md} )) && export LESS_TERMCAP_md=$'\E[1;31m'   # Begins bold.
  (( ! ${+LESS_TERMCAP_me} )) && export LESS_TERMCAP_me=$'\E[0m'      # Ends mode.
  (( ! ${+LESS_TERMCAP_se} )) && export LESS_TERMCAP_se=$'\E[0m'      # Ends standout-mode.
  (( ! ${+LESS_TERMCAP_so} )) && export LESS_TERMCAP_so=$'\E[7m'      # Begins standout-mode.
  (( ! ${+LESS_TERMCAP_ue} )) && export LESS_TERMCAP_ue=$'\E[0m'      # Ends underline.
  (( ! ${+LESS_TERMCAP_us} )) && export LESS_TERMCAP_us=$'\E[1;32m'   # Begins underline.
fi
