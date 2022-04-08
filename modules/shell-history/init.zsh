#
# Enables Shell History.
#
# Authors:
#   Indrajit Raychaudhuri <irc@indrajit.com>
#

# Return if requirements are not found.
# TODO: $(mdfind -name ShellHistory.app) (but check this iff /Applications/ShellHistory.app doesn't exist)
if [[ ! -x ${_shhist_helper::=/Applications/ShellHistory.app/Contents/Helpers/shhist} ]]; then
  return 1
fi

#
# Local Module Installation
#

# Perform iff shhist is installed
if [[ -x ${_shhist_helper::=/Applications/ShellHistory.app/Contents/Helpers/shhist} ]]; then

  # creating an unique session id for each terminal session
  _shhist_session="${RANDOM}"

  # Function to record the history
  _shhist_log() {
    local _exit_code="${?:-1}"
    history -D -t "%s" -1 | \
        sudo --preserve-env --user ${SUDO_USER:-$LOGNAME} \
        $_shhist_helper insert --session ${TERM_SESSION_ID:-$_shhist_session} \
        --username $LOGNAME --hostname $HOST --exit-code $_exit_code
    return $_exit_code
  }

  # Start the autosuggestion widgets on the next precmd
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd _shhist_log

fi
