return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        theme = "catppuccin",
        globalstatus = true,
        section_separators = "",
        component_separators = "",
        refresh = { statusline = 1000 }, -- tick the stopwatch every second
      },
      sections = {
        lualine_y = { require("config.stopwatch").status, "progress" },
      },
    })
  end,
}
