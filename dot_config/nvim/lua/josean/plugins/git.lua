local p = require 'josean.lib.pack'
vim.pack.add { p.gh 'lewis6991/gitsigns.nvim' }

require('gitsigns').setup {
  signs = {
    add = { text = '┃' },
    change = { text = '┃' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
    untracked = { text = '┆' },
  },
}
