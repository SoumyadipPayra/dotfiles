return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "mocha",
    color_overrides = {
      -- default latte accents fall below WCAG AA (4.5:1) against the
      -- latte base for syntax text; darken each while keeping its hue
      -- so code stays readable in the light theme.
      latte = {
        overlay2 = "#686b80", -- Comment
        green = "#2b711c", -- String
        peach = "#ad3f00", -- Number/Boolean/Constant
        blue = "#0553ef", -- Function
        flamingo = "#bb2b2b", -- Identifier
        mauve = "#8027f3", -- Keyword/Statement/Conditional
        yellow = "#8c580f", -- Type
        pink = "#b6188c", -- PreProc/Special
        red = "#c60932", -- Error
        sky = "#006a94", -- Operator
        lavender = "#2949ff", -- CursorLineNr/@property
        teal = "#0f6e74", -- DiagnosticHint
        maroon = "#c41625", -- @parameter
      },
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      telescope = true,
      treesitter = true,
      which_key = true,
      native_lsp = { enabled = true },
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    -- only provides the light theme now; dark uses gruvbox (see gruvbox.lua)
  end,
}
