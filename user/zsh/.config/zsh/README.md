To use this config:

1. Install antibody: `curl -sfL git.io/antibody | sh -s - -b /usr/local/bin` (or use a release tarball/deb). 
2. Install the plugins: `antibody bundle < ~/.config/zsh/antibody > ~/.config/zsh/70_plugins.zsh` 
3. Source `zshrc` into your shell as desire. You can add a simple ~/.zshrc file like this: 

``` sh 
#!/usr/bin/env zsh 
source PATH_TO_THIS_REPO/zshrc 
```

