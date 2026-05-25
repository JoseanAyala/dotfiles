local p = require 'josean.lib.pack'
vim.pack.add { p.gh 'chomosuke/typst-preview.nvim' }

require('typst-preview').setup {}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'typst',
  group = vim.api.nvim_create_augroup('josean-typst-preview', { clear = true }),
  callback = function(ev)
    local map = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { buffer = ev.buf, desc = desc })
    end
    map('<leader>tp', '<cmd>TypstPreview<cr>', '[T]ypst [P]review open')
    map('<leader>ts', '<cmd>TypstPreviewStop<cr>', '[T]ypst preview [S]top')
    map('<leader>tt', '<cmd>TypstPreviewToggle<cr>', '[T]ypst preview [T]oggle')
  end,
})
