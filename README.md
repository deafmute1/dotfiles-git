# dotfiles

## Installing
Requirements: `stow` and `git`

```
git clone "https://github.com/deafmute1/dotfiles"
cd dotfiles 
stow -t ~ -S $(echo * | sed 's/README.md//')
``` 
