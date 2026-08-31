# dotfiles

A personal macOS dev environment: Neovim, tmux, a Starship prompt, and
matching Terminal.app color themes, packaged so it's a one-command setup on
another Mac.

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
  Terminal.app profile instantly, and (if run inside a tmux session) also
  live-reloads tmux's status bar to match.
- **`tmux/`** — `tmux.conf` plus `theme-dark.conf` / `theme-light.conf`.
  Prefix is `C-a` (screen-style, easier reach than the default `C-b`), mouse
  on, vi copy-mode with `y` yanking straight to the macOS clipboard via
  `pbcopy`, splits keep the current pane's directory (`|` / `-`), and
  [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
  makes `Ctrl-h/j/k/l` move seamlessly between tmux panes *and* Neovim
  splits — the same keys this Neovim config already binds for window
  navigation. Sessions persist across restarts automatically via
  [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) +
  [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum). Status
  bar colors match the Terminal.app profiles exactly (same hex values), so
  Terminal, tmux, and Neovim all look like one system.
- **`claude/themes/`** — two custom [Claude Code
  themes](https://code.claude.com/docs/en/terminal-config#create-a-custom-theme),
  `mono-dark.json` ("Mono Dark (Gruvbox)") and `mono-light.json` ("Mono
  Light"), each based on the built-in `dark-ansi`/`light-ansi` presets (so
  anything not explicitly overridden already tracks the terminal's ANSI
  colors) with the spinner/accent, success, error, warning, and diff colors
  overridden to match the same hex values as the Terminal.app profiles.
  Select one with `/theme` inside Claude Code. `tmux/tmux.conf` also
  includes the `allow-passthrough`/`extended-keys` lines Anthropic
  recommends for running Claude Code inside tmux (fixes Shift+Enter and
  desktop notifications there).

## Install on a new Mac

Requires [Homebrew](https://brew.sh) already installed.

```sh
git clone git@github.com:<you>/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

This will:
1. `brew bundle` the `Brewfile` (git, neovim, starship, fzf, zoxide,
   tree-sitter-cli, tmux, the Nerd Font).
2. Symlink `nvim/` → `~/.config/nvim`, `starship/starship.toml` →
   `~/.config/starship.toml`, and `tmux/tmux.conf` → `~/.tmux.conf`
   (backing up anything already there that isn't already one of these
   symlinks).
3. Add one `source` line to `~/.zshrc` for the prompt + `theme` command
   (idempotent — safe to re-run `install.sh` any time).
4. Run `terminal/setup_terminal_theme.py` to set up the two Terminal.app
   profiles.
5. Clone TPM (tmux's plugin manager) if missing, and install all tmux
   plugins non-interactively.
6. Symlink the two Claude Code custom themes into `~/.claude/themes/`.

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
- **Pick a Claude Code theme.** Run `/theme` inside Claude Code and choose
  "Mono Dark (Gruvbox)" or "Mono Light". If `~/.claude/themes/` didn't exist
  before running `install.sh`, restart Claude Code once first (it only
  notices a brand-new themes folder on startup; after that, edits to the
  theme files apply live with no restart).

Neovim's plugins install themselves on first launch via lazy.nvim; the
first startup will take a few seconds longer than usual.

## Notes

- `nvim-treesitter` tracks the `main` branch (the actively-maintained
  rewrite) — `master` is frozen and breaks on newer Neovim releases. `main`
  needs the `tree-sitter` CLI (in the Brewfile as `tree-sitter-cli`,
  distinct from the `tree-sitter` C library formula) to compile parsers.
- `theme` always affects Terminal.app; it additionally reloads tmux's
  status bar only when run from inside a tmux session. If you use a
  different terminal emulator, only the Neovim/Starship/tmux parts apply.
- tmux prefix is `C-a`, not the default `C-b`. `prefix + I` (capital i)
  re-installs/updates plugins by hand if you ever need to (install.sh
  already does this once automatically).
