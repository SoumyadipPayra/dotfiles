return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      contrast = "hard", -- darkest variant, best contrast
      bold = false,
      italic = { strings = false, emphasis = false, comments = false, operators = false, folds = false },
      strikethrough = false,
    })
  end,
}
