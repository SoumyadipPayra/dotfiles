# Neovim Cheatsheet

Leader key: `<Space>`

## Toggles

| Key | Action |
|---|---|
| `<leader>ut` | Toggle theme: dark (gruvbox, hard contrast) ↔ light (catppuccin-latte) |
| `<leader>ua` | Toggle autocomplete popup (nvim-cmp) on/off |
| `<leader>ud` | Toggle diagnostics (errors/warnings) on/off |
| `<leader>uh` | Toggle LSP inlay hints on/off |
| `<leader>us` | Toggle stopwatch: start/pause (shown bottom-right in the statusline) |
| `<leader>uS` | Reset stopwatch |
| `<leader>mp` | Toggle markdown preview (styled) / raw edit mode, current buffer |

## Find / Navigate

| Key | Action |
|---|---|
| `<leader>ff` | Find files (Telescope) |
| `<leader>fg` | Live grep (Telescope) |
| `<leader>fb` | List open buffers (Telescope) |
| `<leader>fh` | Search help tags (Telescope) |
| `<leader>fr` | Recent files (Telescope) |
| `<leader>fd` | List diagnostics (Telescope) |
| `<C-j>` / `<C-k>` | Move selection down/up (inside Telescope prompt) |
| `s` | Flash jump — label-jump to anywhere on screen |
| `S` | Flash treesitter jump — jump to a syntax node |
| `<leader>e` | Toggle file explorer sidebar (neo-tree) |
| `<leader>E` | Reveal current file in the explorer sidebar |
| `-` | Open parent directory in Oil — edit the filesystem like a buffer |
| `:FZF` | Basic fuzzy file finder (Homebrew fzf core plugin) |

### Inside neo-tree (sidebar)
`<CR>`/`l` open · `h` collapse folder · `P` toggle a live floating preview of the file under the cursor (updates as you move) · `a` add file/dir · `d` delete · `r` rename · `?` show all neo-tree keymaps

### Inside Oil (file explorer buffer)
`<CR>` open · `-` go to parent dir · `g?` show all Oil keymaps · save the buffer (`:w`) to apply file changes (rename/create/delete)

## Windows / Buffers

| Key | Action |
|---|---|
| `<C-h/j/k/l>` | Move to left/lower/upper/right window |
| `<C-Up/Down/Left/Right>` | Resize current window |
| `<S-l>` / `<S-h>` | Next / previous buffer (cycle through buffer list) |
| `<leader>bb` | Toggle back to the alternate (last-edited) buffer — quick A/B switch |
| `<leader>fb` | Telescope buffer picker (fuzzy-search open buffers) |
| `<leader>fr` | Telescope recent files (full MRU history across sessions) |
| `<leader>bd` | Delete (close) current buffer |

## Editing

| Key | Action |
|---|---|
| `<A-j>` / `<A-k>` | Move current line (or visual selection) down/up |
| `<` / `>` (visual) | Indent/outdent and keep selection |
| `p` (visual) | Paste over selection without losing your yank register |
| `x` | Delete char without yanking it |
| `<C-d>` / `<C-u>` | Half-page scroll, keeps cursor centered |
| `n` / `N` | Next/prev search match, centered |
| `<Esc>` | Clear search highlight |
| `gcc` | Toggle line comment (Comment.nvim) |
| `gc` (visual) | Toggle comment on selection |
| `ys<motion><char>` | Add surround, e.g. `ysiw"` to wrap word in quotes (nvim-surround) |
| `cs<old><new>` | Change surround, e.g. `cs"'` |
| `ds<char>` | Delete surround, e.g. `ds"` |
| autopairs | Brackets/quotes auto-close as you type |
| clipboard | All yank/delete/paste use the system clipboard automatically |

## LSP (clangd / pylsp / lua_ls — attaches automatically per filetype)

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | List references |
| `gI` | Go to implementation |
| `K` | Hover documentation |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename symbol |
| `<leader>cd` | Show diagnostic(s) on current line |
| `[d` / `]d` | Jump to previous/next diagnostic |
| `<C-Space>` (insert) | Trigger completion manually |
| `<C-j>` / `<C-k>` (insert) | Next/previous completion item |
| `<Tab>` / `<S-Tab>` (insert) | Next/prev item, or expand/jump snippet |
| `<CR>` (insert, popup open) | Confirm completion |
| `<C-e>` (insert) | Abort completion |

## Run code

| Key | Action |
|---|---|
| `<leader>rr` | Compile (C/C++) and run the current file in a terminal split |
| `<Esc><Esc>` (terminal mode) | Exit back to normal mode |

Supported filetypes: C++ (`g++ -std=c++17`), C (`gcc`), Python (`python3`), Java (`java`).

## Plugin / tooling management

| Command | Action |
|---|---|
| `:Lazy` | Open plugin manager UI (install/update/clean) |
| `:Mason` | Open LSP/tool installer UI |
| `:MasonInstall <name>` | Install a specific tool, e.g. `:MasonInstall jdtls` for Java |
| `:TSInstall <lang>` | Install a Treesitter parser for a language |
| `:checkhealth` | Diagnose config/plugin issues |

## Notes

- Python LSP is **pylsp** (installs via pip). Pyright would need Node.js — if you install it later, swap `"pylsp"` → `"pyright"` in `lua/plugins/lsp.lua`.
- Config layout: `init.lua` loads `lua/config/*` (options, keymaps, toggles, runner, autocmds) and `lua/plugins/*` (one file per plugin group, managed by lazy.nvim).
- Formatting is intentionally minimal — no autoformatter is installed; just consistent 4-space indent.
- `nvim-treesitter` tracks the `main` branch (the rewritten API) since `master` is frozen and breaks on newer Neovim. Its parser installer shells out to the `tree-sitter` CLI (`brew install tree-sitter-cli`, separate from the `tree-sitter` library formula) — if `:TSInstall`/`:TSUpdate` ever errors with "no such file: tree-sitter", that CLI is missing.
- File explorer: `neo-tree.nvim` is the sidebar (`<leader>e`); `oil.nvim` is still there for editing a directory as a buffer (`-`). They're kept deliberately separate (`hijack_netrw_behavior = "disabled"` on neo-tree) so they don't fight over netrw.
