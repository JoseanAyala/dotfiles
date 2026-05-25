vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Move windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Delete buffers
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = '+[D]elete current buffer' })
vim.keymap.set('n', '<leader>bD', ':%bdelete<CR>', { desc = '+[D]elete all buffers' })

-- Yank entire buffer
vim.keymap.set('n', '<leader>Y', 'ggyG<C-o>', { desc = '+[Y]ank buffer' })

-- ctrl + c  to ciw
vim.keymap.set('n', '<C-c>', 'ciw')

-- Move selected lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Rename current word
vim.keymap.set('n', '<leader>rw', [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { desc = '+[R]ename [W]ord' })

-- Move to beggining and end of row in howerow
vim.keymap.set('n', 'H', '^')
vim.keymap.set('n', 'L', '$')

-- Builds
local builds = require 'josean.lib.builds'
vim.keymap.set('n', '<leader>pa', function()
  builds.build_service 'auth'
end, { desc = 'Build Auth' })
vim.keymap.set('n', '<leader>pp', function()
  builds.build_service 'proxy'
end, { desc = 'Build Proxy' })
vim.keymap.set('n', '<leader>pe', function()
  builds.build_service 'accounts'
end, { desc = 'Build Python Endpoints' })
vim.keymap.set('n', '<leader>pd', function()
  builds.build_service 'destinations-dispatcher-worker'
end, { desc = 'Build Destinations Dispatcher' })
vim.keymap.set('n', '<leader>pi', function()
  builds.build_service 'digital-signature-worker'
end, { desc = 'Build Digital Signature' })
vim.keymap.set('n', '<leader>pv', function()
  builds.build_service 'events-worker'
end, { desc = 'Build Events' })
vim.keymap.set('n', '<leader>pf', function()
  builds.build_service 'pdf-to-pdf-worker'
end, { desc = 'Build PDF to PDF' })
vim.keymap.set('n', '<leader>pc', function()
  builds.build_service 'renders-combine-worker'
end, { desc = 'Build Renders Combine' })
vim.keymap.set('n', '<leader>pr', function()
  builds.build_service 'renders-process-worker'
end, { desc = 'Build Renders Process' })
vim.keymap.set('n', '<leader>ps', function()
  builds.build_service 'salesforce-worker'
end, { desc = 'Build Salesforce' })

-- Yanks
local yank = require 'josean.lib.yank'

vim.keymap.set('n', '<leader>ya', function()
  yank.yank_path(yank.get_buffer_absolute(), 'absolute')
end, { desc = '[Y]ank [A]bsolute path to clipboard' })

vim.keymap.set('n', '<leader>yp', function()
  yank.yank_path(yank.get_buffer_cwd_relative(), 'relative')
end, { desc = '[Y]ank relative [P]ath to clipboard' })

vim.keymap.set('v', '<leader>ya', function()
  yank.yank_visual_with_path(yank.get_buffer_absolute(), 'absolute')
end, { desc = '[Y]ank selection with [A]bsolute path' })

vim.keymap.set('v', '<leader>yp', function()
  yank.yank_visual_with_path(yank.get_buffer_cwd_relative(), 'relative')
end, { desc = '[Y]ank selection with relative [P]ath' })

-- SQL
local sql = require 'josean.lib.sql'

vim.keymap.set('n', '<leader>df', function()
  sql.run_file()
end, { desc = 'Run SQL [F]ile' })

vim.keymap.set('n', '<leader>dq', function()
  sql.run_query()
end, { desc = 'Run SQL [Q]uery' })

vim.keymap.set('v', '<leader>ds', function()
  sql.run_selection()
end, { desc = 'Run SQL [S]election' })
