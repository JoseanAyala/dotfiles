-- filetype detection
vim.filetype.add {
  filename = {
    ['Tiltfile'] = 'starlark',
  },
}

-- auto-reload files changed outside of neovim
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
  group = vim.api.nvim_create_augroup('josean-auto-reload', { clear = true }),
  command = 'silent! checktime',
})

-- auto-reload tmux when .tmux.conf is saved
vim.api.nvim_create_autocmd('BufWritePost', {
  group = vim.api.nvim_create_augroup('josean-tmux-reload', { clear = true }),
  pattern = { '*.tmux.conf', 'tmux.conf' },
  callback = function()
    if vim.fn.executable 'tmux' == 1 and vim.env.TMUX then
      vim.fn.system 'tmux source-file ~/.tmux.conf'
      vim.notify('tmux config reloaded', vim.log.levels.INFO)
    end
  end,
})

-- highlight yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('josean-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
