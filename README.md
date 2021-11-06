# dotfiles

## Installing
Requirements: `stow git`

```
git clone "https://github.com/deafmute1/dotfiles"
cd dotfiles 
stow -t ~ -S $(echo user/*)
stow -t /etc -S $(echo system/*)
``` 
