return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
    { "<leader>E", "<cmd>Neotree reveal<cr>", desc = "Reveal current file in explorer" },
  },
  opts = {
    close_if_last_window = true,
    window = {
      width = 32,
      mappings = {
        ["P"] = { "toggle_preview", config = { use_float = true } },
        ["l"] = "open",
        ["h"] = "close_node",
      },
    },
    filesystem = {
      -- Oil already owns netrw (edit-directory-as-buffer via "-");
      -- keep neo-tree out of that so the two don't fight over it.
      hijack_netrw_behavior = "disabled",
      follow_current_file = { enabled = true },
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
    default_component_configs = {
      git_status = {
        symbols = {
          added = "✚",
          modified = "",
          deleted = "✖",
          renamed = "➜",
          untracked = "★",
          ignored = "◌",
          unstaged = "✗",
          staged = "✓",
          conflict = "",
        },
      },
    },
  },
}
