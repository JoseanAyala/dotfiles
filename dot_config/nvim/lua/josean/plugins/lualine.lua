local p = require 'josean.lib.pack'
vim.pack.add { p.gh 'nvim-lualine/lualine.nvim' }

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { '|', '|' },
    section_separators = { '', '' },
    disabled_filetypes = {},
    globalstatus = vim.o.laststatus == 3,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = {},
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
}
