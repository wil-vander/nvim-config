return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      -- Advertise blink.cmp's completion capabilities to every server
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Keymaps when a server attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufopts = { noremap = true, silent = true, buffer = args.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        end,
      })

      -- Install these servers and enable them automatically
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls", -- Lua
          "pyright", -- Python
          "ts_ls", -- TypeScript/JavaScript
          "rust_analyzer", -- Rust
          "gopls", -- Go
          "clangd", -- C/C++
          "svelte", -- Svelte
        },
        automatic_enable = true,
      })

      -- Diagnostic display
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          source = "if_many",
        },
        float = {
          source = true,
          border = "rounded",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
    end,
  },
}
