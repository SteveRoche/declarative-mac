# declarative-mac

Nix configurations and dotfiles for my Macbook. Based on nix-darwin and homebrew.

## Installation

(untested)

```shell
$ sh <(curl -L https://nixos.org/nix/install)
$ curl -o- https://raw.githubusercontent.com/SteveRoche/declarative-mac/main/install.sh | bash
```

In iTerm2, General -> Settings - load settings from `dotfiles/iterm2`

## Editing

- Edit files in `~/.config/nix-darwin`
- Run `rebuild`

## TODO

- [ ] Sync VS Code settings
