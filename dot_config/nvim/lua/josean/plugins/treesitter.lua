local p = require 'josean.lib.pack'
vim.pack.add {
  { src = p.gh 'nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = p.gh 'nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
  p.gh 'nvim-treesitter/nvim-treesitter-context',
  p.gh 'tpope/vim-sleuth',
}

require('nvim-treesitter').install {
  'bash',
  'css',
  'dockerfile',
  'go',
  'gomod',
  'gosum',
  'html',
  'javascript',
  'json',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'python',
  'rego',
  'sql',
  'starlark',
  'toml',
  'tsx',
  'typescript',
  'typst',
  'vim',
  'vimdoc',
  'yaml',
}

vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})

require('nvim-treesitter-textobjects').setup {
  select = { lookahead = true },
  move = { set_jumps = true },
}

local select = require 'nvim-treesitter-textobjects.select'
local move = require 'nvim-treesitter-textobjects.move'
local swap = require 'nvim-treesitter-textobjects.swap'

local select_keymaps = {
  ['af'] = '@function.outer',
  ['if'] = '@function.inner',
  ['ac'] = '@class.outer',
  ['ic'] = '@class.inner',
  ['ap'] = '@parameter.outer',
  ['ip'] = '@parameter.inner',
}
for keys, query in pairs(select_keymaps) do
  vim.keymap.set({ 'x', 'o' }, keys, function()
    select.select_textobject(query)
  end)
end

local move_keymaps = {
  goto_next_start = {
    [']f'] = '@function.outer',
    [']c'] = '@class.outer',
    [']a'] = '@parameter.inner',
  },
  goto_next_end = {
    [']F'] = '@function.outer',
    [']C'] = '@class.outer',
    [']A'] = '@parameter.inner',
  },
  goto_previous_start = {
    ['[f'] = '@function.outer',
    ['[c'] = '@class.outer',
    ['[a'] = '@parameter.inner',
  },
  goto_previous_end = {
    ['[F'] = '@function.outer',
    ['[C'] = '@class.outer',
    ['[A'] = '@parameter.inner',
  },
}
for method, keymaps in pairs(move_keymaps) do
  for keys, query in pairs(keymaps) do
    vim.keymap.set({ 'n', 'x', 'o' }, keys, function()
      move[method](query)
    end)
  end
end

vim.keymap.set('n', '>p', function()
  swap.swap_next '@parameter.inner'
end)
vim.keymap.set('n', '<p', function()
  swap.swap_previous '@parameter.inner'
end)

require('treesitter-context').setup {
  enable = true,
  max_lines = 3,
  trim_scope = 'inner',
  min_window_height = 10,
}
