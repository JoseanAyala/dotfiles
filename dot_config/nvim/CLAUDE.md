# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration using the native **`vim.pack`** plugin manager (via a thin wrapper at `lua/josean/lib/pack.lua`). All configuration is written in Lua and targets Neovim 0.12+.

## Architecture

**Entry point:** `init.lua` loads options, then iterates `lua/josean/plugins/` (alphabetically) and `require`s each file, then loads keymaps and autocmds. There is no plugin-manager bootstrap step — each plugin file calls `vim.pack.add { ... }` itself.

**Load order:** `options.lua` -> each file in `lua/josean/plugins/` (in alphabetical order) -> `keymaps.lua` -> `autocmds.lua`

**Key directories:**
- `lua/josean/plugins/` — Plugin files (auto-discovered by `init.lua`); each file installs its plugins via `pack.add` and configures them
- `lua/josean/lib/` — Custom utility modules (`pack` wrapper, builds, yank helpers)
- `lsp/` — Native LSP server configs (Neovim 0.10+ `vim.lsp.config` format, one file per server)

**Plugin lock file:** `nvim-pack-lock.json` is managed by `vim.pack` and should be committed.

## Conventions

- **Leader key:** Space
- **Indentation:** 2 spaces, expandtab (both for the config itself and as default editor setting)
- **Lua formatting:** stylua (runs on save via conform.nvim)
- **Format on save** is enabled for all filetypes except C/C++ (via conform.nvim)
- **LSP servers** are configured in `lsp/*.lua` using the native `vim.lsp.config` pattern and enabled in `lua/josean/plugins/lsp.lua` via `vim.lsp.enable`
- **Plugin files** in `lua/josean/plugins/` are imperative: they call `vim.pack.add { ... }` to install plugins, then configure them inline (no spec table is returned)
- **Plugin sources** use the URL helpers from `lua/josean/lib/pack.lua` — `p.gh 'owner/repo'`, `p.gl 'owner/repo'`, `p.cb 'owner/repo'`, `p.srht '~user/repo'` — which return full URL strings
- Nerd Font icons are assumed available (`vim.g.have_nerd_font = true`)
- Transparent background is enabled in the colorscheme (tokyonight)

## Key Plugin Stack

- **Completion:** blink.cmp (with friendly-snippets, dadbod completion)
- **Picker/Explorer/Dashboard:** snacks.nvim (replaces telescope, nvim-tree, alpha)
- **Formatting:** conform.nvim (stylua, prettierd, gofumpt, goimports, ruff)
- **LSP:** Mason for installing servers/tools, native `vim.lsp` for configuration
- **Git:** gitsigns.nvim, lazygit (via snacks.nvim)
- **UI:** which-key, noice.nvim, lualine, fidget.nvim, nvim-scrollbar
- **AI:** claudecode.nvim (`<leader>a` prefix)
- **Database:** vim-dadbod + dadbod-ui (`<leader>D` or `<leader>db`)

## Custom Modules

**`lua/josean/lib/pack.lua`** — URL simplifiers used with `vim.pack.add`. Each helper (`gh`, `gl`, `cb`, `srht`) takes `'owner/repo'` and returns the full URL string.

**`lua/josean/lib/builds.lua`** — Runs `make dev-update-service SERVICE=<name>` asynchronously with fidget.nvim progress and Snacks error windows. Keymaps are under `<leader>p`.

**`lua/josean/lib/yank.lua`** — Yanks file paths (absolute/relative) and visual selections with path+line annotations to clipboard. Keymaps are under `<leader>y`.

## Managing Plugins

- **Update all:** `:lua vim.pack.update()` (shows a confirmation diff buffer; add `{ force = true }` as the second arg to skip)
- **Update some:** `:lua vim.pack.update({ 'snacks.nvim', 'blink.cmp' })`
- **List installed:** `:lua =vim.pack.get()`
- **Remove:** `:lua vim.pack.del({ 'plugin-name' })`

## Adding a New Plugin

Either add the source to an existing related file's `vim.pack.add { ... }` call, or create a new file in `lua/josean/plugins/` that calls `vim.pack.add { p.gh 'owner/repo', ... }` (with `local p = require 'josean.lib.pack'`) and configures the plugin. It will be auto-loaded on next start.

## Adding a New LSP Server

1. Create `lsp/<server_name>.lua` with `return { ... }` config
2. Add the server name to `vim.lsp.enable` in `lua/josean/plugins/lsp.lua`
3. Add the Mason package name to `ensure_installed` in the same file
