# dotfiles

Personal configuration, synced across machines with [`mise dot`](https://mise.jdx.dev/).

## What's inside

| Path | Tool |
| --- | --- |
| `home/.config/fish` | [fish](https://fishshell.com) shell: config, functions, completions |
| `home/.config/nvim` | [Neovim](https://neovim.io) |
| `home/.config/ghostty` | [Ghostty](https://ghostty.org) terminal |
| `home/.config/tmux` | tmux |
| `home/.config/sesh` | [sesh](https://github.com/joshmedeiros/sesh) session manager |
| `home/.config/herdr` | herdr |
| `home/.config/rex` | rex |
| `home/.gitignore_global` | global gitignore |
| `config/` | mise config (`config.toml`, `config.work.toml`) and tasks |

## How it works

The files are tracked by `mise dot` (see the `[dotfiles]` section of `~/.config/mise/config.toml`), which
captures changes as checkpoints in `.mise-history/` and syncs them with this repo. Files are not meant to
be edited here directly.

```sh
mise dot status   # see what's tracked and sync state
mise dot save     # capture local edits
```

## Secrets

Secrets are never committed. `mise dot` omits credential files automatically, and fish loads local-only
values from `~/.config/fish/secrets.fish` (see `secrets.fish.example` for the expected keys).

## Using it

These are personal settings, so don't expect to apply them as-is. Feel free to borrow ideas.
