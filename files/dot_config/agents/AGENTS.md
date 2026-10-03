## Development Tools

Use modern tools whenever possible. The following are examples. Tools are installed via the package
manager or via homebrew on Mac OS, but also with mise (https://mise.jdx.dev).

- **yq** - YAML processor
- **fd** - File finder
- **rg** - ripgrep for searching text
- **sd** - replacement for sed
- **prettier** - YAML formatting
- **taplo** - TOML formatting

Install all tools with: `mise install`.

## General Workflow

- When taking screenshots for debugging or analysis, create a subdirectory in /tmp/ and save there,
  and never to the project root or other permanent locations.

- Always check the system time when doing any reasoning about time. Always state the time zone when
  stating times.

### Git Constraints

- **DO NOT PERFORM ANY GIT CHANGES WITHOUT USER INSTRUCTION.** Always ask before performing any git
  commands.
