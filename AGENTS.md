# AGENTS.md

This is a [chezmoi](https://www.chezmoi.io/) dotfiles repository. Chezmoi manages
dotfiles across machines by maintaining source files here that get applied to `$HOME`.

## Layout

- `.chezmoiroot` points to `files/` as the chezmoi source directory.
- `files/` contains all managed dotfiles using chezmoi naming conventions:
  - `dot_` prefix maps to `.` (e.g., `dot_zshenv` -> `~/.zshenv`)
  - `.tmpl` suffix indicates Go template files (rendered with chezmoi data)
  - `bin/` maps to `~/bin/`
  - `dot_config/` maps to `~/.config/`
- `mise.toml` defines tool versions (chezmoi, hk, shfmt) and a `deploy` task.
- `hk.pkl` configures pre-commit hooks (formatting, linting).

## Editing dotfiles

Always edit the source files in `files/`, never the target files in `$HOME` directly.
`chezmoi apply` overwrites `$HOME` from this repo. Changes made directly to e.g.
`~/.config/git/config` will be lost on the next apply.

To pull changes from a deployed file back into the repo, use `chezmoi add <file>`
(e.g., `chezmoi add ~/.config/git/config`). This updates the corresponding source file in
`files/` from the live version, enabling a bidirectional workflow when needed.

To modify a dotfile, map the target path back to its source name:
- `~/.zshenv` -> `files/dot_zshenv`
- `~/.config/git/config` -> `files/dot_config/git/config.tmpl`
- `~/.config/foo/bar` -> `files/dot_config/foo/bar`

## Template variables

`.tmpl` files use Go template syntax. The only custom data variable is `email`,
defined in `files/.chezmoi.toml.tmpl`. Chezmoi also provides built-in variables
like `.chezmoi.os`, `.chezmoi.hostname`, `.chezmoi.arch`, etc.

## Key conventions

- Pre-commit hooks auto-fix formatting via hk (prettier, shfmt, taplo, pkl, etc.).
- Deploy with `mise run deploy` which runs `chezmoi apply --init`.
