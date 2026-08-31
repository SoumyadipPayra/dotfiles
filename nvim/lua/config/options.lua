local opt = vim.opt

-- ui
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.showmode = false -- statusline shows mode instead
opt.cmdheight = 1
opt.laststatus = 3
opt.pumheight = 10
opt.splitright = true
opt.splitbelow = true
opt.completeopt = "menu,menuone,noselect"

-- indentation (kept minimal & consistent, no autoformatter)
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.autoindent = true
opt.smartindent = true

-- search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- files / undo
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("state") .. "/undo"

-- clipboard: yank/paste/delete go to the system clipboard
opt.clipboard = "unnamedplus"

-- responsiveness
opt.updatetime = 250
opt.timeoutlen = 400

-- fzf core plugin from Homebrew (gives the :FZF command)
vim.opt.rtp:append("/opt/homebrew/opt/fzf")
