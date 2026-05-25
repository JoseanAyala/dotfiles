local p = require 'josean.lib.pack'
vim.pack.add {
  p.gh 'nvim-lua/plenary.nvim',
  p.gh 'folke/todo-comments.nvim',
}

require('todo-comments').setup {}

local map = vim.keymap.set
map('n', '<leader>st', function()
  Snacks.picker.todo_comments()
end, { desc = 'Todo Comments' })
map('n', '<leader>sT', function()
  Snacks.picker.todo_comments { keywords = { 'TODO', 'FIX', 'FIXME' } }
end, { desc = 'Todo/Fix/Fixme' })
map('n', ']t', function()
  require('todo-comments').jump_next()
end, { desc = 'Next Todo Comment' })
map('n', '[t', function()
  require('todo-comments').jump_prev()
end, { desc = 'Previous Todo Comment' })
