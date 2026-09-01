local map = vim.keymap.set
local toggles = require("config.toggles")
local runner = require("config.runner")
local stopwatch = require("config.stopwatch")

-- clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>")

-- delete without yanking
map("n", "x", '"_x')

-- window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- resize windows
map("n", "<C-Up>", "<cmd>resize +2<cr>")
map("n", "<C-Down>", "<cmd>resize -2<cr>")
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>")

-- buffers
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>bb", "<C-^>", { desc = "Toggle alternate (last) buffer" })

-- move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- keep selection when (de)indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- paste over a visual selection without losing the yank register
map("v", "p", '"_dP')

-- centered scrolling / search
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- diagnostics navigation
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- toggles
map("n", "<leader>ut", toggles.toggle_theme, { desc = "Toggle light/dark theme" })
map("n", "<leader>ua", toggles.toggle_autocomplete, { desc = "Toggle autocomplete" })
map("n", "<leader>ud", toggles.toggle_diagnostics, { desc = "Toggle diagnostics" })
map("n", "<leader>uh", toggles.toggle_inlay_hints, { desc = "Toggle inlay hints" })
map("n", "<leader>us", stopwatch.toggle, { desc = "Toggle stopwatch (start/pause)" })
map("n", "<leader>uS", stopwatch.reset, { desc = "Reset stopwatch" })

-- run current file (compiles C/C++ first)
map("n", "<leader>rr", runner.run_file, { desc = "Run current file" })

-- escape terminal mode easily
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
