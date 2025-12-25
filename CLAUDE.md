# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles repository for managing shell configurations (zsh/oh-my-zsh), vim/neovim, tmux, git, and development tools across macOS, Linux, and Windows.

## Installation

```bash
./setup.sh
```

Creates symlinks from `$HOME` to dotfiles, backing up existing files to `.old/<timestamp>/`. Auto-detects OS and installs appropriate configs from `common/`, `darwin/`, `linux/`, or `windows/`.

### Symlink Structure

Files from source directories are symlinked as `~/.{filename}`:
- `common/zshrc` → `~/.zshrc`
- `common/vimrc` → `~/.vimrc`
- `common/tmux.conf` → `~/.tmux.conf`
- etc.

Special cases:
- `common/zprofile` → `~/.zprofile` (PATH setup for login shells)
- `common/aliases.d` → `~/.aliases.d` (modular function files)
- `common/oh-my-zsh/custom/custom` → `~/.oh-my-zsh/custom/custom`
- `common/config/alacritty` → `~/.config/alacritty`
- `common/vim` → `~/.config/nvim` (for neovim)
- `common/vimrc` → `~/.config/nvim/init.vim` (for neovim)

## Coding Standards

EditorConfig (`.editorconfig`) enforces:
- UTF-8 charset
- Spaces for indentation
- LF line endings
- Trim trailing whitespace
- Insert final newline (except markdown)

## Shell Configuration Architecture

The shell environment uses a **multi-file zsh configuration** that splits concerns:

### Shell Startup Files (Order Matters!)

**For login shells** (new terminal tabs, `omz reload`, SSH):
1. `/etc/zprofile` - System-wide (runs `path_helper`, can mess up PATH order)
2. **`common/zprofile`** → `~/.zprofile` - **PATH management** (fixes Homebrew and user bin order)
3. **`common/zshrc`** → `~/.zshrc` - Main interactive config (oh-my-zsh, plugins, aliases)

**For non-login shells** (typing `zsh` in terminal):
1. **`common/zshrc`** → `~/.zshrc` - Only this file runs

### Configuration Files

1. **common/zprofile** - PATH setup for login shells
   - Ensures correct PATH order: `$HOME/.bin` → `$HOME/bin` → `/opt/homebrew/bin` → `/opt/homebrew/sbin` → rest
   - Removes and re-adds paths to fix order issues caused by `/etc/zprofile`
   - Critical for macOS where `/usr/bin` can override Homebrew tools

2. **common/zshrc** - Main entry point
   - Custom oh-my-zsh location: `ZSH_CUSTOM=$HOME/.oh-my-zsh/custom/custom` (double "custom" is intentional)
   - Theme: `dracula`
   - Sources `~/.aliases` before loading oh-my-zsh
   - Platform-specific plugins loaded conditionally
   - **Requires**: `brew install zsh-autosuggestions`

3. **common/aliases** - Functions and helpers (despite the name)
   - OS detection functions: `is_darwin()`, `is_linux()`, `is_windows()`, `is_openwrt()`
   - `binary_exists()` for checking command availability
   - Editor wrapper functions: `vim()` → `nvim`, `vi()` → `vim`
   - Upgrade helpers: `upgrade_brew_packages()`, `upgrade_vim_plugins()`, `upgrade_tmux_plugins()`, `upgrade_ohmyzsh()`
   - Sources all files from `~/.aliases.d/` for modular function organization

4. **common/oh-my-zsh/custom/custom/exports.zsh** - Environment variables
   - EDITOR selection (nvim > vim > vi)
   - Go paths: `GOBIN=${HOME}/go/bin`, `GOPATH=${HOME}/go/`
   - NVM initialization

5. **common/oh-my-zsh/custom/custom/paths.zsh** - PATH modifications (fallback for non-login shells)
   - Adds user bin directories if not already present
   - Works with zprofile for comprehensive PATH coverage

**Bash alternative**: `common/bashrc` also sources `~/.aliases` for cross-shell compatibility

### Critical Pattern: OS Detection

All shell scripts use helper functions from `common/aliases`:
```bash
if is_darwin; then
    # macOS code
elif is_linux; then
    # Linux code
fi
```

### Modular Function Organization

Functions are organized using the **aliases.d pattern** for better maintainability:

- **Location**: `common/aliases.d/` (symlinked to `~/.aliases.d/`)
- **Loading**: `common/aliases` automatically sources all files in `~/.aliases.d/`
- **Pattern**: Each topic gets its own file (e.g., `cyberchef`, `docker`, `kubernetes`)

**Example: CyberChef Functions** (`common/aliases.d/cyberchef`):
- `cyberchef_start` - Start container (port configurable via `CYBERCHEF_PORT`, defaults to 8080)
- `cyberchef_stop` - Stop container
- `cyberchef_open` - Open in browser (auto-starts if needed)
- `cyberchef_restart` - Restart container
- `cyberchef_update` - Pull latest image and recreate container

To add new modular functions:
1. Create a new file in `common/aliases.d/`
2. Add `# vi: set ft=sh:` at the top for proper syntax highlighting
3. Functions automatically available after running `setup.sh` and reloading shell

### Custom oh-my-zsh Plugin Overrides

Custom plugin overrides in `~/.oh-my-zsh/custom/custom/plugins/` take precedence over default oh-my-zsh plugins:

**gcloud plugin override** (`~/.oh-my-zsh/custom/custom/plugins/gcloud/gcloud.plugin.zsh`):
- Fixes PATH duplication issue in default oh-my-zsh gcloud plugin
- Adds gcloud bin path only if not already present (prevents growth in nested shells)
- Maintains all completion functionality from the original plugin
- **Important**: This override prevents the default plugin from sourcing `path.zsh.inc` which unconditionally prepends to PATH

## Vim/Neovim Setup

- **Plugin manager**: vim-plug (auto-installs if missing)
- **Plugins stored**: `~/.tmp/vim/plugged/` (keeps `$HOME` clean)
- **Neovim config**: Setup script symlinks `common/vim` → `~/.config/nvim` and `common/vimrc` → `~/.config/nvim/init.vim`
- **Key plugins**: coc.nvim (LSP), NERDTree, ctrlp.vim, vim-fugitive, vim-airline, dracula theme

Update plugins: `upgrade_vim_plugins` (runs `:PlugUpdate` and `:PlugUpgrade`)

## tmux Configuration

- **Config**: common/tmux.conf
- **Prefix key**: Ctrl+a (screen-style, not default Ctrl+b)
- **Key bindings**: Vi-mode enabled for copy mode and status keys
- **Plugins stored**: `~/.tmp/tmux/plugins/`
- **Plugin manager**: TPM auto-installs on first run if missing
- **Theme**: Dracula with plugins (battery, network, weather, time)
- **Version-specific workarounds**: tmux 2.2 needs `EVENT_NOKQUEUE`/`EVENT_NOEPOLL` (handled in aliases)
- **Always runs with**: `tmux -2` (256 color)

Update plugins: `upgrade_tmux_plugins`

## Git Configuration

Platform-specific git configs:
- **darwin/gitconfig** - macOS settings
- **linux/gitconfig** - Linux settings

When modifying git config, edit the appropriate OS-specific file, not common/.

## Utility Scripts (common/bin/)

Helper scripts for docker operations, git utilities, and other tools. All are in PATH after setup.

## Package Management

- **packages/darwin/brew.lst** - Homebrew packages for macOS
- **packages/linux/apt-get.lst** - APT packages for Linux

Lists include taps, formulas, fonts, and casks with inline notes about version/hardware requirements.
