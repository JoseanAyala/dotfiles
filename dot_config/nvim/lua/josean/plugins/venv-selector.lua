local p = require 'josean.lib.pack'
vim.pack.add { p.gh 'linux-cultist/venv-selector.nvim' }

require('venv-selector').setup {
  options = {
    picker = 'snacks',
    notify_user_on_venv_activation = true,
  },
}

vim.keymap.set('n', '<leader>cv', '<cmd>VenvSelect<cr>', { desc = 'Select VirtualEnv' })
