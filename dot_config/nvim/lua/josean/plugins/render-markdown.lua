local p = require 'josean.lib.pack'
vim.pack.add {
  p.gh 'nvim-tree/nvim-web-devicons',
  p.gh 'MeanderingProgrammer/render-markdown.nvim',
}

require('render-markdown').setup {
  code = {
    disable = { 'mermaid' },
  },
}
