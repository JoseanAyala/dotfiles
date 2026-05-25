local p = require 'josean.lib.pack'
vim.pack.add {
  p.gh 'rafamadriz/friendly-snippets',
  p.gh 'saghen/blink.cmp',
}

require('blink.cmp').setup {
  keymap = {
    preset = 'enter',
    ['<C-y>'] = { 'select_and_accept' },
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono',
  },
  completion = {
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },
    menu = {
      border = 'single',
      draw = {
        treesitter = { 'lsp' },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = { border = 'single' },
    },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'dadbod' },
    providers = {
      dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
    },
  },
  cmdline = {
    sources = {},
  },
}
