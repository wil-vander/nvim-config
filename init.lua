require("config.lazy")

-- Basic settings
vim.o.number = true -- Enable line numbers
vim.o.relativenumber = false -- Enable relative line numbers
vim.o.tabstop = 2 -- Number of spaces a tab represents
vim.o.shiftwidth = 2 -- Number of spaces for each indentation
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.smartindent = true -- Automatically indent new lines
vim.o.wrap = false -- Disable line wrapping
vim.o.cursorline = true -- Highlight the current line
vim.o.termguicolors = true -- Enable 24-bit RGB colors

-- Show markers on tabs, trailing spaces, and one per indent level in leading spaces
vim.o.list = true
vim.opt.listchars = {
  tab = '→ ',
  trail = '·',
  leadmultispace = '→' .. string.rep(' ', vim.o.shiftwidth - 1),
}

-- Dim whitespace markers; reapplied on ColorScheme so a theme reload doesn't reset them
local function set_whitespace_hl()
  vim.api.nvim_set_hl(0, 'Whitespace', { fg = '#393939' }) -- oxocarbon base02
end
set_whitespace_hl()
vim.api.nvim_create_autocmd('ColorScheme', { callback = set_whitespace_hl })

-- Treesitter-based folding (everything open by default)
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldlevelstart = 99

-- Syntax highlighting and filetype plugins
vim.cmd('syntax enable')
vim.cmd('filetype plugin indent on')

-- Leader key
vim.g.mapleader = ' ' -- Space as the leader key
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<CR>', { noremap = true, silent = true })

