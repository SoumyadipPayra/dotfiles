-- nvim-treesitter's "master" branch (legacy API) is frozen and breaks on
-- newer Neovim core changes (e.g. NVIM v0.12.5). "main" is the actively
-- maintained rewrite with a different setup API: it only installs
-- parsers; highlighting/indent are enabled per-filetype via core APIs.
local parsers = { "c", "cpp", "python", "java", "lua", "vim", "vimdoc", "bash", "markdown" }
local filetypes = { "c", "cpp", "python", "java", "lua", "vim", "help", "sh", "markdown" }

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })
    require("nvim-treesitter").install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetypes,
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
