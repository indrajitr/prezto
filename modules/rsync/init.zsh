#
# Defines Rsync aliases.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Return if requirements are not found.
if (( ! $+commands[rsync] )); then
  return 1
fi

# Load dependencies.
pmodload 'helper'

#
# Aliases
#

_rsync_cmd='rsync --verbose --progress --human-readable --compress --archive \
  --hard-links --one-file-system'

autoload -Uz is-at-least
if is-at-least 3.1 ${"$(rsync --version 2>&1)"[(w)3]}; then

  # ACL and extended attributes support
  if [[ ${(@M)${(f)"$(rsync --help 2>&1)"}:#*xattrs*} ]]; then
    _rsync_cmd="${_rsync_cmd} --acls --xattrs"
  fi

  # macOS Enhancements
  # https://bombich.com/kb/ccc5/credits
  if is-darwin && [[ ${(@M)${(f)"$(rsync --help 2>&1)"}:#*file-flags*} ]]; then
    _rsync_cmd="${_rsync_cmd} --crtimes --fileflags --force-change"
  fi
fi

alias rsync-copy="${_rsync_cmd}"
alias rsync-move="${_rsync_cmd} --remove-source-files"
alias rsync-update="${_rsync_cmd} --update"
alias rsync-synchronize="${_rsync_cmd} --update --delete"

unset _rsync_cmd
