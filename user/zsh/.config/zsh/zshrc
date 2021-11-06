# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

MYDIR="$(dirname "$(readlink -f "$0")")"

#source all configs
# ls -v1 enables conf.d style numerical loading orders
# e.g. 1_file.zsh loads after 0_file.zsh
for file in $(ls -v1 "$MYDIR"/autosource/*.zsh); do 
  source "$file"
done

#if [[ -z "$SUPRESS_LOGIN" ]] ; then 
#  source "${MYDIR}/loginmsg.zsh" 
#fi

[[ ! -f ~/.config/broot/launcher/bash/br ]] || source ~/.config/broot/launcher/bash/br
