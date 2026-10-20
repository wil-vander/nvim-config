return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>lf",
      function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
    {
      "<leader>uf",
      function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        vim.notify("Format on save: " .. (vim.g.disable_autoformat and "off" or "on"))
      end,
      desc = "Toggle format on save",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_format" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      svelte = { "prettier_svelte" },
      go = { "gofmt" },
      rust = { "rustfmt" },
    },
    formatters = {
      -- prettier + prettier-plugin-svelte. Uses the project's copy of the plugin when
      -- it's in node_modules; otherwise falls back to the one in nvim's data dir
      -- (~/.local/share/nvim/prettier-plugins).
      prettier_svelte = {
        inherit = "prettier",
        prepend_args = function(_, ctx)
          local project = vim.fs.find("node_modules/prettier-plugin-svelte", {
            path = ctx.dirname,
            upward = true,
          })[1]
          -- prettier wants the entry file, not the package directory
          local dir = project or (vim.fn.stdpath("data") .. "/prettier-plugins/node_modules/prettier-plugin-svelte")
          return { "--plugin", dir .. "/plugin.js" }
        end,
      },
    },
    -- Skipped when vim.g.disable_autoformat is set (toggle with <leader>uf)
    format_on_save = function()
      if vim.g.disable_autoformat then
        return
      end
      return { timeout_ms = 1000, lsp_format = "fallback" }
    end,
  },
}
