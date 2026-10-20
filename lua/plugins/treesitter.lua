return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local parsers = {
      "lua", "vim", "vimdoc", "javascript", "typescript", "python", "rust",
      "go", "html", "css", "json", "yaml", "toml", "markdown", "bash", "svelte",
    }
    require("nvim-treesitter").install(parsers)

    -- Enable highlighting and indentation for any filetype with a parser
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        if pcall(vim.treesitter.start, args.buf) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
