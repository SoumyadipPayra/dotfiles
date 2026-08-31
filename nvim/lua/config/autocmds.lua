-- flash a highlight on yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})

-- let 'q' close throwaway/utility buffers
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "qf", "lspinfo", "checkhealth", "man", "notify" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})
