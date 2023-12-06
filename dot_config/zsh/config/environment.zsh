# Generic options and environment settings

# Use smart URL pasting and escaping.
autoload -Uz bracketed-paste-url-magic && zle -N bracketed-paste bracketed-paste-url-magic
autoload -Uz url-quote-magic && zle -N self-insert url-quote-magic

setopt AUTO_RESUME          # Treat single word simple commands without redirection as candidates for resumption of an existing job.
setopt INTERACTIVE_COMMENTS # Allow comments starting with `#` even in interactive shells.
setopt NO_FLOW_CONTROL      # disable start (C-s) and stop (C-q) characters
setopt CORRECT              # Suggest command corrections
setopt LONG_LIST_JOBS       # List jobs in the long format by default.
setopt NOTIFY               # Report the status of background jobs immediately, rather than waiting until just before printing a prompt.
setopt NO_BG_NICE           # Prevent runing all background jobs at a lower priority.
setopt NO_CHECK_JOBS        # Prevent reporting the status of background and suspended jobs before exiting a shell with job control. NO_CHECK_JOBS is best used only in combination with NO_HUP, else such jobs will be killed automatically.
setopt NO_HUP               # Prevent sending the HUP signal to running jobs when the shell exits.

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}


# Global config

# Better spell checking & auto correction prompt
export SPROMPT="zsh: correct %F{red}'%R'%f to %F{blue}'%r'%f [%B%Uy%u%bes, %B%Un%u%bo, %B%Ue%u%bdit, %B%Ua%u%bbort]? "

# Temporary Files
if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR" &> /dev/null
fi
TMPPREFIX="${TMPDIR%/}/zsh"

# Ensure ccache only uses compilers here
export CCACHE_PATH="/usr/bin"

# GPG and SSH
export GPG_TTY=$TTY
gpg-connect-agent /bye &> /dev/null
