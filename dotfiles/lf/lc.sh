# Change working directory in shell to last dir in lf on exit
# source this file add the command
# keybinding in zsh
# bindkey -s '^o' 'lfcd\n'

lc() {
  # `command` is needed in case `lfcd` is aliased to `lf`
  cd "$(command lf -print-last-dir "$@")"
}
