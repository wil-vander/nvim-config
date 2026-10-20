return {
  "nyoom-engineering/oxocarbon.nvim",
  lazy = false, -- colorschemes must be available at startup
  priority = 1000, -- load before every other plugin
  config = function()
    vim.opt.background = "dark"
    vim.cmd.colorscheme("oxocarbon")
  end,
}
