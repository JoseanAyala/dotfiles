local p = require 'josean.lib.pack'
vim.pack.add {
  p.gh 'tpope/vim-dadbod',
  p.gh 'kyazdani42/nvim-web-devicons',
  p.gh 'kristijanhusak/vim-dadbod-ui',
  p.gh 'kristijanhusak/vim-dadbod-completion',
}

local data_path = vim.fn.stdpath 'data'
vim.g.db_ui_auto_execute_table_helpers = 1
vim.g.db_ui_save_location = data_path .. '/dadbod_ui'
vim.g.db_ui_show_database_icon = true
vim.g.db_ui_tmp_query_location = data_path .. '/dadbod_ui/tmp'
vim.g.db_ui_use_nerd_fonts = true
vim.g.db = vim.env.DB_URL

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'dbout',
  callback = function()
    vim.bo.buflisted = false
    vim.bo.swapfile = false
    vim.keymap.set('n', 'q', ':bd!<CR>', { buffer = true, silent = true })
  end,
})

vim.keymap.set('n', '<leader>D', '<cmd>DBUIToggle<CR>', { desc = 'DB Toggle' })
