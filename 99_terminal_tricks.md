# Notes on Terminal / `bash` session configuration
Eric Pante 

## `bash` session config

bash reads `~/.bash_profile`, then `~/.bashrc`. 
On my Mac I have `fish`, which I control with `~/.config/fish/config.fish`

`fish`function:
```
function seadog
   echo 'publishing seadog on github ...'
   echo ''
   cd ~/Documents/GitHub/ericpante.github.io/seadog
   quarto publish gh-pages
end
```


## useful aliases 

```
alias ifb="sshpass -p PASSWORD ssh USERNAME@core.cluster.france-bioinformatique.fr"
alias ccat='pygmentize -g -O style=github-dark,linenos=1'
alias eza="eza -l -s oldest -r --icons=always"
```


## `eza`

replacement for `ls`; on Mac, need a `nerd` font, installed with `brew install --cask font-jetbrains-mono-nerd-font`

