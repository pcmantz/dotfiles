# AGENTS.md

This is a [chezmoi](https://www.chezmoi.io/) dotfiles repository. Chezmoi manages
dotfiles across machines by maintaining source files here that get applied to `$HOME`.

## Layout

- `.chezmoiroot` points to `files/` as the chezmoi source directory.
- `files/` contains all managed dotfiles using chezmoi naming conventions:
  - `dot_` prefix maps to `.` (e.g., `dot_gitconfig.tmpl` -> `~/.gitconfig`)
  - `.tmpl` suffix indicates Go template files (rendered with chezmoi data)
  - `bin/` maps to `~/bin/`
  - `dot_config/` maps to `~/.config/`
- `mise.toml` defines tool versions (chezmoi, hk, shfmt) and a `deploy` task.
- `hk.pkl` configures pre-commit hooks (formatting, linting).

## Key conventions

- Templates use chezmoi's Go template syntax with data from `.chezmoi.toml.tmpl`.
- Pre-commit hooks auto-fix formatting via hk (prettier, shfmt, taplo, pkl, etc.).
- Deploy with `mise run deploy` which runs `chezmoi apply --init`.
