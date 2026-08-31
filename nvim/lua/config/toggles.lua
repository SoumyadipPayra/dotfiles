-- Central place for every on/off toggle in this config.
local M = {}

-- ============ theme: light / dark ============
-- dark = gruvbox (hard contrast), light = catppuccin-latte
M.theme_state = "dark"
vim.o.background = "dark"
vim.cmd.colorscheme("gruvbox")

function M.toggle_theme()
  if M.theme_state == "dark" then
    M.theme_state = "light"
    vim.o.background = "light"
    vim.cmd.colorscheme("catppuccin-latte")
  else
    M.theme_state = "dark"
    vim.o.background = "dark"
    vim.cmd.colorscheme("gruvbox")
  end
  vim.notify("Theme: " .. M.theme_state, vim.log.levels.INFO)
end

-- ============ autocomplete popup ============
vim.g.cmp_enabled = true

function M.toggle_autocomplete()
  vim.g.cmp_enabled = not vim.g.cmp_enabled
  vim.notify("Autocomplete: " .. (vim.g.cmp_enabled and "ON" or "OFF"), vim.log.levels.INFO)
end

-- ============ diagnostics: errors / warnings ============
function M.toggle_diagnostics()
  local enabled = vim.diagnostic.is_enabled()
  vim.diagnostic.enable(not enabled)
  vim.notify("Diagnostics: " .. (not enabled and "ON" or "OFF"), vim.log.levels.INFO)
end

-- ============ inlay hints ============
function M.toggle_inlay_hints()
  local buf = vim.api.nvim_get_current_buf()
  local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
  vim.lsp.inlay_hint.enable(not enabled, { bufnr = buf })
  vim.notify("Inlay hints: " .. (not enabled and "ON" or "OFF"), vim.log.levels.INFO)
end

return M
