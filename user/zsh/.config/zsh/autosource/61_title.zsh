# Provides terminal title in format: user@host: <$0 of last run cmd> 

# precmd uses history (via fc) to catch the last run command in history.
# preexec overrules it with "$1" which is set to the current command for cases
# where the command is long lived, most obviously for interactive/TUI commands e.g. vim. 

precmd () {
  print -Pn "\e]0;$USER@$HOST: $(fc -ln -1 | head -n1 | cut -d' ' -f1)\a"
}

preexec() {
  print -Pn "\e]0;$USER@$HOST: $(echo "$1" | cut -d' ' -f1)\a"  
}
