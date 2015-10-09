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

#
# Aliases
#

_rsync_cmd='rsync --verbose --inplace --progress --human-readable --compress --archive \
  --hard-links --one-file-system'

if grep -q 'xattrs' <(rsync --help 2>&1); then
  _rsync_cmd="${_rsync_cmd} --acls --xattrs"
fi

alias rsync-copy="${_rsync_cmd}"
alias rsync-move="${_rsync_cmd} --remove-source-files"
alias rsync-update="${_rsync_cmd} --update"
alias rsync-synchronize="${_rsync_cmd} --update --delete"

# Mac OS X and HFS+ Enhancements
# http://help.bombich.com/kb/overview/credits#opensource
if [[ "$OSTYPE" == darwin* ]] && grep -q 'file-flags' <(rsync --help 2>&1); then
  _rsync_cmd_osx="${_rsync_cmd} --crtimes --fileflags --protect-decmpfs --force-change"
  alias rsync-copy-osx="${_rsync_cmd_osx}"
  alias rsync-move-osx="${_rsync_cmd_osx} --remove-source-files"
  alias rsync-update-osx="${_rsync_cmd_osx} --update"
  alias rsync-synchronize-osx="${_rsync_cmd_osx} --update --delete"
  unset _rsync_cmd_osx
fi

unset _rsync_cmd
