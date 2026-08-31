# dotfiles

A personal macOS dev environment: Neovim, a Starship prompt, and matching
Terminal.app color themes, packaged so it's a one-command setup on another
Mac.

## What's here

- **`nvim/`** — full Neovim config (lazy.nvim-managed). Gruvbox (hard
  contrast) for dark, Catppuccin Latte (contrast-corrected for reading code)
  for light, toggled with `<leader>ut`. LSP via Mason (clangd/pylsp/lua_ls),
  Telescope, a neo-tree sidebar with live file preview (`<leader>e`, `P` to
  preview), Oil for editing a directory as a buffer (`-`), render-markdown
  for a preview/edit toggle on `.md` files (`<leader>mp`), Treesitter (on
  its `main` branch — see note below), and more. Full reference:
  `nvim/CHEATSHEET.md`.
- **`starship/starship.toml`** — a minimal prompt: path, git branch, a
  single dot if the repo is dirty (nothing if clean), and the time on the
  right. No line-break, no clutter.
- **`terminal/setup_terminal_theme.py`** — creates two Terminal.app
  profiles, `Mono Light` and `Mono Dark` (JetBrainsMono Nerd Font Mono,
  15pt), each with a full 16-color ANSI palette re-tuned to clear WCAG AA
  contrast (Gruvbox-darker for dark; a cool-neutral background with bold,
  high-contrast accents for light — not Gruvbox's cream).
- **`zsh/nvim-dotfiles.zsh`** — Starship init, plus a `theme` shell function
  (`theme light` / `theme dark` / `theme toggle`) that switches the live
  Terminal.app profile instantly.

## Install on a new Mac

Requires [Homebrew](https://brew.sh) already installed.

```sh
git clone git@github.com:<you>/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

This will:
1. `brew bundle` the `Brewfile` (git, neovim, starship, fzf, zoxide,
   tree-sitter-cli, the Nerd Font).
2. Symlink `nvim/` → `~/.config/nvim` and `starship/starship.toml` →
   `~/.config/starship.toml` (backing up anything already there that isn't
   already one of these symlinks).
3. Add one `source` line to `~/.zshrc` for the prompt + `theme` command
   (idempotent — safe to re-run `install.sh` any time).
4. Run `terminal/setup_terminal_theme.py` to set up the two Terminal.app
   profiles.

Because it's a symlink, `nvim/` in this repo *is* the live config — edit it
in place on any machine and `git commit`/`push` from `~/dotfiles`.

### Two manual steps after install

- **Quit and reopen Terminal.app once.** Font/background/text/cursor apply
  live, but Terminal's AppleScript interface doesn't expose the 16 ANSI
  colors at all — they're written directly into
  `~/Library/Preferences/com.apple.Terminal.plist` in Terminal's own
  NSKeyedArchiver format, which Terminal only reads at launch. There's no
  API to make it reload that live.
- **Open a new shell** (or `source ~/.zshrc`) to pick up the prompt and the
  `theme` command.

Neovim's plugins install themselves on first launch via lazy.nvim; the
first startup will take a few seconds longer than usual.

## Notes

- `nvim-treesitter` tracks the `main` branch (the actively-maintained
  rewrite) — `master` is frozen and breaks on newer Neovim releases. `main`
  needs the `tree-sitter` CLI (in the Brewfile as `tree-sitter-cli`,
  distinct from the `tree-sitter` C library formula) to compile parsers.
- `theme` only affects Terminal.app. If you use a different terminal
  emulator, only the Neovim/Starship parts of this repo apply.
