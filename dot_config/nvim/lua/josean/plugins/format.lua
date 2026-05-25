local p = require 'josean.lib.pack'
vim.pack.add { p.gh 'stevearc/conform.nvim' }

require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    local disable_filetypes = { c = true, cpp = true }
    local lsp_format_opt
    if disable_filetypes[vim.bo[bufnr].filetype] then
      lsp_format_opt = 'never'
    else
      lsp_format_opt = 'fallback'
    end
    return {
      timeout_ms = 1000,
      lsp_format = lsp_format_opt,
    }
  end,
  formatters_by_ft = {
    lua = { 'stylua' },
    typst = { 'typstyle' },
    sql = { 'pg_format' },
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
    javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    css = { 'prettierd', 'prettier', stop_after_first = true },
    html = { 'prettierd', 'prettier', stop_after_first = true },
    json = { 'prettierd', 'prettier', stop_after_first = true },
    yaml = { 'prettierd', 'prettier', stop_after_first = true },
    go = { 'goimports-reviser', 'gofumpt' },
    rego = { 'opa_fmt' },
    python = { 'ruff_organize_imports', 'ruff_format' },
  },
}

vim.keymap.set('', '<leader>=', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = 'Format buffer' })
