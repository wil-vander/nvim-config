-- Statusline layouts. Every preset spells out all sections so switching
-- between them never leaves anything behind from the previous one.
local presets = {
  default = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  minimal = {
    lualine_a = { "mode" },
    lualine_b = {},
    lualine_c = { { "filename", path = 0 } },
    lualine_x = { "diagnostics" },
    lualine_y = {},
    lualine_z = { "location" },
  },
  detailed = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff" },
    lualine_c = { { "filename", path = 1 }, "diagnostics" },
    lualine_x = {
      {
        function()
          local names = vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients({ bufnr = 0 }))
          return #names > 0 and table.concat(names, ",") or ""
        end,
        icon = "",
      },
      "encoding",
      "fileformat",
      "filetype",
    },
    lualine_y = { "progress", "location" },
    lualine_z = { function() return os.date("%H:%M") end },
  },
}
local order = { "default", "minimal", "detailed" }
local current = "default"

local function apply(name)
  if not presets[name] then
    vim.notify("Unknown statusline preset: " .. name, vim.log.levels.ERROR)
    return
  end
  current = name
  require("lualine").setup({
    options = {
      theme = "auto",
      globalstatus = true,
      section_separators = { left = "", right = "" },
      component_separators = { left = "|", right = "|" },
    },
    sections = presets[name],
    inactive_sections = {},
  })
  vim.notify("Statusline: " .. name)
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    apply(current)
    vim.api.nvim_create_user_command("StatuslinePreset", function(args)
      if args.args == "" then
        vim.ui.select(order, { prompt = "Statusline preset" }, function(choice)
          if choice then apply(choice) end
        end)
      else
        apply(args.args)
      end
    end, {
      nargs = "?",
      complete = function() return order end,
      desc = "Switch statusline preset",
    })
  end,
  keys = {
    {
      "<leader>us",
      function()
        for i, name in ipairs(order) do
          if name == current then
            apply(order[i % #order + 1])
            return
          end
        end
      end,
      desc = "Cycle statusline preset",
    },
  },
}
