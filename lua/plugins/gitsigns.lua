return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  init = function()
    -- Darker green for added lines (Tango "dark green"); reapplied after colorscheme changes
    local function set_hl()
      vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#4e9a06" })
    end
    set_hl()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hl })
  end,
  opts = {
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
      end

      map("]h", function() gs.nav_hunk("next") end, "Next hunk")
      map("[h", function() gs.nav_hunk("prev") end, "Previous hunk")
      map("<leader>hp", gs.preview_hunk, "Preview hunk")
      map("<leader>hs", gs.stage_hunk, "Stage hunk")
      map("<leader>hr", gs.reset_hunk, "Reset hunk")
      map("<leader>hb", gs.blame_line, "Blame line")
    end,
  },
}
