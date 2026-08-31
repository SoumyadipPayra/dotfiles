return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({})
    wk.add({
      { "<leader>f", group = "find" },
      { "<leader>u", group = "toggle/ui" },
      { "<leader>c", group = "code" },
      { "<leader>b", group = "buffer" },
      { "<leader>r", group = "run/rename" },
      { "<leader>m", group = "markdown" },
    })
  end,
}
