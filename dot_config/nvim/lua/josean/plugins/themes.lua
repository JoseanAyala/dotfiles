local p = require 'josean.lib.pack'
vim.pack.add { p.gh 'folke/tokyonight.nvim' }

require('tokyonight').setup {
  transparent = true,
}
vim.cmd 'colorscheme tokyonight'
