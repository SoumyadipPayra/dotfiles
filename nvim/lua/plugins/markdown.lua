return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown" },
  opts = {},
  keys = {
    {
      "<leader>mp",
      "<cmd>RenderMarkdown buf_toggle<cr>",
      ft = "markdown",
      desc = "Toggle markdown preview/edit",
    },
  },
}
