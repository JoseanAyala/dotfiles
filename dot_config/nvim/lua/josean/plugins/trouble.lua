local p = require 'josean.lib.pack'
vim.pack.add { p.gh 'folke/trouble.nvim' }

require('trouble').setup {}

local map = vim.keymap.set
map('n', '<leader>qa', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { desc = 'Buffer Diagnostics (Trouble)' })
map('n', '<leader>qA', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Project Diagnostics (Trouble)' })
map('n', '<leader>qs', '<cmd>Trouble symbols toggle focus=false<cr>', { desc = 'Symbols (Trouble)' })
map('n', '<leader>qL', '<cmd>Trouble loclist toggle<cr>', { desc = 'Location List (Trouble)' })
map('n', '<leader>qQ', '<cmd>Trouble qflist toggle<cr>', { desc = 'Quickfix List (Trouble)' })
map('n', '<leader>qt', '<cmd>Trouble todo<cr>', { desc = 'Todo (Trouble)' })

map('n', '[q', function()
  if require('trouble').is_open() then
    require('trouble').prev { skip_groups = true, jump = true }
  else
    local ok, err = pcall(vim.cmd.cprev)
    if not ok then
      vim.notify(err, vim.log.levels.ERROR)
    end
  end
end, { desc = 'Previous Trouble/Quickfix Item' })

map('n', ']q', function()
  if require('trouble').is_open() then
    require('trouble').next { skip_groups = true, jump = true }
  else
    local ok, err = pcall(vim.cmd.cnext)
    if not ok then
      vim.notify(err, vim.log.levels.ERROR)
    end
  end
end, { desc = 'Next Trouble/Quickfix Item' })
