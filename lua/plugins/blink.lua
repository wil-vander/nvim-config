return {
  "saghen/blink.cmp",
  version = "1.*", -- release tags ship prebuilt fuzzy-matcher binaries
  event = "InsertEnter",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- "default": <C-y> accept, <C-n>/<C-p> select, <C-space> open menu, <C-e> hide
    keymap = { preset = "default" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    completion = {
      documentation = { auto_show = true },
    },
  },
}
