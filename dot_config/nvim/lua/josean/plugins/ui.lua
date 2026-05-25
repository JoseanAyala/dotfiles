local p = require 'josean.lib.pack'
vim.pack.add {
  p.gh 'folke/which-key.nvim',
  p.gh 'MunifTanjim/nui.nvim',
  p.gh 'folke/noice.nvim',
  p.gh 'petertriho/nvim-scrollbar',
}

require('which-key').setup {
  icons = {
    mappings = vim.g.have_nerd_font,
    keys = vim.g.have_nerd_font and {} or {
      Up = '<Up> ',
      Down = '<Down> ',
      Left = '<Left> ',
      Right = '<Right> ',
      C = '<C-…> ',
      M = '<M-…> ',
      D = '<D-…> ',
      S = '<S-…> ',
      CR = '<CR> ',
      Esc = '<Esc> ',
      ScrollWheelDown = '<ScrollWheelDown> ',
      ScrollWheelUp = '<ScrollWheelUp> ',
      NL = '<NL> ',
      BS = '<BS> ',
      Space = '<Space> ',
      Tab = '<Tab> ',
      F1 = '<F1>',
      F2 = '<F2>',
      F3 = '<F3>',
      F4 = '<F4>',
      F5 = '<F5>',
      F6 = '<F6>',
      F7 = '<F7>',
      F8 = '<F8>',
      F9 = '<F9>',
      F10 = '<F10>',
      F11 = '<F11>',
      F12 = '<F12>',
    },
  },
  win = {
    border = 'rounded',
    width = { min = 20, max = 50 },
    col = math.huge,
    padding = { 1, 2 },
  },
  spec = {
    { '<leader>b', group = '[B]uffer' },
    { '<leader>p', group = 'Build & [P]ush' },
    { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
    { '<leader>d', group = '[D]ocument | [D]B' },
    { '<leader>r', group = '[R]ename' },
    { '<leader>f', group = '[F]ind' },
    { '<leader>w', group = '[W]orkspace' },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>g', group = '[G]it', mode = { 'n', 'v' } },
    { '<leader>q', group = 'Trouble' },
  },
}

require('noice').setup {
  cmdline = {
    enabled = true,
    view = 'cmdline',
  },
  messages = {
    enabled = true,
    view = 'mini',
  },
  presets = {
    bottom_search = true,
  },
}

require('scrollbar').setup {
  handlers = { cursor = false },
}
