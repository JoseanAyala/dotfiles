-- blink.cmp must be set up before this file: get_lsp_capabilities() below reads it.
require 'josean.plugins.blink'

local p = require 'josean.lib.pack'
vim.pack.add {
  p.gh 'Bilal2453/luvit-meta',
  p.gh 'folke/lazydev.nvim',
  p.gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  p.gh 'williamboman/mason.nvim',
}

require('lazydev').setup {
  library = {
    { path = 'luvit-meta/library', words = { 'vim%.uv' } },
    { path = 'snacks.nvim', words = { 'Snacks' } },
  },
}

require('mason').setup()
require('mason-tool-installer').setup {
  ensure_installed = {
    -- LSP servers
    'gopls',
    'lua-language-server',
    'typescript-language-server',
    'tailwindcss-language-server',
    'basedpyright',
    'ruff',
    'tinymist',
    -- Formatters
    'stylua',
    'prettierd',
    'gofumpt',
    'goimports-reviser',
    'typstyle',
  },
}

if vim.g.have_nerd_font then
  local signs = { ERROR = '🤡', WARN = '😬', INFO = '🤓', HINT = '🧠' }
  local diagnostic_signs = {}
  for type, icon in pairs(signs) do
    diagnostic_signs[vim.diagnostic.severity[type]] = icon
  end
  vim.diagnostic.config {
    signs = { text = diagnostic_signs },
    virtual_text = { spacing = 2, prefix = '' },
  }
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('josean-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
    map('K', function()
      local clients = vim.lsp.get_clients { bufnr = event.buf, method = vim.lsp.protocol.Methods.textDocument_hover }
      if #clients == 0 then
        return
      end
      if #clients > 1 then
        vim.lsp.buf_request_all(event.buf, vim.lsp.protocol.Methods.textDocument_hover, vim.lsp.util.make_position_params(), function(results)
          for client_id, result in pairs(results) do
            if not result.error and result.result and result.result.contents then
              local c = vim.lsp.get_client_by_id(client_id)
              if c then
                local md = vim.lsp.util.convert_input_to_markdown_lines(result.result.contents)
                if #md > 0 then
                  vim.lsp.util.open_floating_preview(md, 'markdown', { focus_id = 'lsp_hover' })
                  return
                end
              end
            end
          end
        end)
      else
        vim.lsp.buf.hover()
      end
    end, 'Hover')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup('josean-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('josean-lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'josean-lsp-highlight', buffer = event2.buf }
        end,
      })
    end

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.lsp.enable { 'gopls', 'lua_ls', 'ts_ls', 'tailwindcss', 'basedpyright', 'ruff', 'tilt_ls', 'tinymist' }
