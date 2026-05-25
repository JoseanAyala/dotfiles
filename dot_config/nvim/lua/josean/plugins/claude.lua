local p = require 'josean.lib.pack'
vim.pack.add { p.gh 'coder/claudecode.nvim' }

require('claudecode').setup {}

local map = vim.keymap.set
map({ 'n', 'v' }, '<leader>a', '', { desc = '+ai' })
map('n', '<leader>ac', '<cmd>ClaudeCode<cr>', { desc = 'Toggle Claude' })
map('n', '<leader>af', '<cmd>ClaudeCodeFocus<cr>', { desc = 'Focus Claude' })
map('n', '<leader>ar', '<cmd>ClaudeCode --resume<cr>', { desc = 'Resume Claude' })
map('n', '<leader>aC', '<cmd>ClaudeCode --continue<cr>', { desc = 'Continue Claude' })
map('n', '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', { desc = 'Add current buffer' })
map('v', '<leader>as', '<cmd>ClaudeCodeSend<cr>', { desc = 'Send to Claude' })
map('n', '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', { desc = 'Accept diff' })
map('n', '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', { desc = 'Deny diff' })

-- ClaudeCodeTreeAdd binds <leader>as for tree filetypes only
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'NvimTree', 'neo-tree', 'oil' },
  callback = function(ev)
    vim.keymap.set('n', '<leader>as', '<cmd>ClaudeCodeTreeAdd<cr>', { buffer = ev.buf, desc = 'Add file' })
  end,
})
