#!/usr/bin/env bash
# Sets up this Neovim config + Starship prompt + Terminal.app theme on a
# fresh Mac. Safe to re-run (idempotent): symlinks are re-created in place,
# the .zshrc snippet is only added once, and the Terminal theme script just
# re-applies the same values.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "$(uname)" != "Darwin" ]]; then
  echo "This dotfiles setup targets macOS only (Terminal.app theming, Homebrew)." >&2
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Install it first: https://brew.sh" >&2
  exit 1
fi

echo "==> Installing packages from Brewfile"
brew bundle --file="$DOTFILES_DIR/Brewfile"

echo "==> Linking Neovim config"
mkdir -p "$HOME/.config"
if [[ -e "$HOME/.config/nvim" && ! -L "$HOME/.config/nvim" ]]; then
  backup="$HOME/.config/nvim.bak.$(date +%s)"
  echo "    existing ~/.config/nvim found, backing up to $backup"
  mv "$HOME/.config/nvim" "$backup"
fi
ln -sfn "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

echo "==> Linking Starship config"
if [[ -e "$HOME/.config/starship.toml" && ! -L "$HOME/.config/starship.toml" ]]; then
  backup="$HOME/.config/starship.toml.bak.$(date +%s)"
  echo "    existing ~/.config/starship.toml found, backing up to $backup"
  mv "$HOME/.config/starship.toml" "$backup"
fi
ln -sfn "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

echo "==> Wiring the prompt + theme switcher into ~/.zshrc"
SNIPPET_TARGET="$DOTFILES_DIR/zsh/nvim-dotfiles.zsh"
MARKER="# dotfiles: starship prompt + theme switcher"
if ! grep -qF "$MARKER" "$HOME/.zshrc" 2>/dev/null; then
  {
    printf '\n%s (see %s)\n' "$MARKER" "$DOTFILES_DIR"
    printf '[ -f "%s" ] && source "%s"\n' "$SNIPPET_TARGET" "$SNIPPET_TARGET"
  } >> "$HOME/.zshrc"
  echo "    added source line to ~/.zshrc"
else
  echo "    already present in ~/.zshrc, skipping"
fi

echo "==> Setting up Terminal.app color profiles (Mono Light / Mono Dark)"
python3 "$DOTFILES_DIR/terminal/setup_terminal_theme.py"

echo ""
echo "Done."
echo "  - Open a new shell (or 'source ~/.zshrc') to get the prompt + 'theme' command."
echo "  - Quit and reopen Terminal.app once to see the full accent color palette."
echo "  - Open nvim: plugins install automatically on first launch (via lazy.nvim)."
