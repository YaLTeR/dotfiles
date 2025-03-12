My dotfiles, managed with [chezmoi].

First, install chezmoi, for example via:

```sh
sh -c "$(curl -fsLS get.chezmoi.io/lb)"
```

Then, init, verify the diff, and apply:

```sh
chezmoi init YaLTeR
chezmoi diff
chezmoi apply
```

The `before-chezmoi` tag points at the last commit before switching to chezmoi.

[chezmoi]: https://www.chezmoi.io/
