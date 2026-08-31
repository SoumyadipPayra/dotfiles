local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  install = { colorscheme = { "gruvbox" } },
  checker = { enabled = false },
  change_detection = { notify = false },
  -- keep custom runtimepath entries (e.g. Homebrew's fzf) that lazy would
  -- otherwise prune during its startup rtp optimization
  performance = { rtp = { reset = false } },
})
