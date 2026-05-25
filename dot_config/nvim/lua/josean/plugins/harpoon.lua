local p = require 'josean.lib.pack'
vim.pack.add {
  p.gh 'nvim-lua/plenary.nvim',
  { src = p.gh 'ThePrimeagen/harpoon', version = 'harpoon2' },
}

local harpoon = require 'harpoon'
harpoon:setup {
  menu = {
    width = vim.api.nvim_win_get_width(0) - 4,
  },
  settings = {
    save_on_toggle = true,
  },
}

local map = vim.keymap.set
map('n', '<leader>H', function()
  harpoon:list():add()
end, { desc = 'Harpoon File' })
map('n', '<leader>h', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Harpoon Quick Menu' })

for i = 1, 9 do
  map('n', '<leader>' .. i, function()
    harpoon:list():select(i)
  end, { desc = 'Harpoon to File ' .. i })
end
