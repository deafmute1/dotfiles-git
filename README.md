# dotfiles

## Installing
Requirements: `stow` and `git`

```
git clone "https://github.com/deafmute1/dotfiles"
cd dotfiles 
stow -t ~ -S $(ls | tr '\n' ' ')
``` 
