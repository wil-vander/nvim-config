return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>b", group = "buffer" },
      { "<leader>f", group = "find" },
      { "<leader>g", group = "github" },
      { "<leader>h", group = "git hunks" },
      { "<leader>n", group = "notifications" },
      { "<leader>u", group = "ui" },
      { "<leader>z", group = "zoom/dim" },
    },
  },
  keys = {
    {
      "<leader>?",
      function() require("which-key").show({ global = false }) end,
      desc = "Buffer-local keymaps",
    },
  },
}
