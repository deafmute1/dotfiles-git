# Locale
export LC_COLLATE=en_AU.UTF-8
export LC_CTYPE=en_AU.UTF-8
export LC_MESSAGES=en_AU.UTF-8
export LC_MONETARY=en_AU.UTF-8
export LC_NUMERIC=en_AU.UTF-8
export LC_TIME=en_AU.UTF-8
export LC_ALL=en_AU.UTF-8
export LANG=en_AU.UTF-8
export LANGUAGE=en_AU.UTF-8
export LESSCHARSET=utf-8

# Editor 
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER='nvim +Man!'

## Application specific 
export SPACEVIMDIR=~/.config/SpaceVim.d/
export CARGO_HOME=~/.local/cargo 
#FZF search command 
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
# See man rem(1) 
export DOTREMINDERS=~/.local/share/remind/combine


#my vars 
export STUDENT_ID='31458946'

#PATH 
export PATH=~/.local/bin:~/.local/cargo/bin:$PATH
# Remove duplicates from PATH by setting its bound variable, path (note the lower case) to a unique array.
# The only real benefit of doing so is reducing lookup time for binaries
# Please don't ask me why this lowercase path varible exists
typeset -aU path 
