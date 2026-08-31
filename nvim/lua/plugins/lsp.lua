return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    opts = {
      -- clangd: C/C++, pylsp: Python (installs via pip, no Node.js needed), lua_ls: this config.
      -- want pyright instead? `brew install node` then swap "pylsp" for "pyright" below and here.
      -- add more with :Mason (e.g. jdtls for Java).
      ensure_installed = { "clangd", "pylsp", "lua_ls" },
    },
  },
  {
    -- ships the default per-server configs consumed by vim.lsp.config/enable below
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "mason-lspconfig.nvim" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- diagnostics = warning/error checking, toggled with <leader>ud
      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        severity_sort = true,
        underline = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "E",
            [vim.diagnostic.severity.WARN] = "W",
            [vim.diagnostic.severity.HINT] = "H",
            [vim.diagnostic.severity.INFO] = "I",
          },
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local map = function(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = event.buf, desc = desc })
          end
          map("gd", vim.lsp.buf.definition, "Goto definition")
          map("gD", vim.lsp.buf.declaration, "Goto declaration")
          map("gr", vim.lsp.buf.references, "Goto references")
          map("gI", vim.lsp.buf.implementation, "Goto implementation")
          map("K", vim.lsp.buf.hover, "Hover doc")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>cd", vim.diagnostic.open_float, "Line diagnostics")
        end,
      })

      local servers = { "clangd", "pylsp", "lua_ls" }
      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = capabilities })
      end

      -- pylsp's bundled pycodestyle defaults to a 79-char max line length,
      -- which doesn't match most real projects (e.g. Black/Ruff's common
      -- 119 default, used by huggingface/diffusers among others).
      vim.lsp.config("pylsp", {
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = { maxLineLength = 119 },
            },
          },
        },
      })

      vim.lsp.enable(servers)
    end,
  },
}
