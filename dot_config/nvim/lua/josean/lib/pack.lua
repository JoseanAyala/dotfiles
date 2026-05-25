-- URL simplifiers for vim.pack.add. Each helper takes 'owner/repo' and
-- returns the full URL string.
--
--   local p = require('josean.lib.pack')
--   vim.pack.add { p.gh 'folke/snacks.nvim', p.gl 'foo/bar' }

local function host(base)
  return function(path)
    return base .. path
  end
end

local M = {
  gh = host 'https://github.com/',
  gl = host 'https://gitlab.com/',
  cb = host 'https://codeberg.org/',
  srht = host 'https://git.sr.ht/',
}

-- Lazy.nvim-style picker for vim.pack: list plugins, <CR> to update selected,
-- `U` to update all, `D` to delete. Updates still surface vim.pack's native
-- diff-confirmation buffer.
local function find_readme(dir)
  for _, name in ipairs { 'README.md', 'readme.md', 'Readme.md', 'README', 'README.markdown' } do
    local p = dir .. '/' .. name
    if vim.uv.fs_stat(p) then
      return p
    end
  end
end

function M.ui()
  local items = {}
  for _, p in ipairs(vim.pack.get()) do
    local name = p.spec.name or p.spec.src
    items[#items + 1] = {
      text = ('%-30s %s'):format(name, p.spec.src),
      name = name,
      src = p.spec.src,
      file = find_readme(p.path),
    }
  end

  Snacks.picker.pick {
    source = 'pack',
    title = 'vim.pack',
    items = items,
    format = function(item)
      return { { item.text } }
    end,
    preview = 'file',
    confirm = function(picker, item)
      local sel = picker:selected { fallback = true }
      local names = {}
      for _, it in ipairs(sel) do
        names[#names + 1] = it.name
      end
      picker:close()
      vim.pack.update(names)
    end,
    win = {
      list = {
        keys = {
          ['U'] = { 'pack_update_all', mode = { 'n' }, desc = 'Update all' },
          ['D'] = { 'pack_delete', mode = { 'n' }, desc = 'Delete' },
        },
      },
    },
    actions = {
      pack_update_all = function(picker)
        picker:close()
        vim.pack.update()
      end,
      pack_delete = function(picker, item)
        if not item then
          return
        end
        vim.ui.input({ prompt = ('Delete %s? (y/N) '):format(item.name) }, function(input)
          if input and input:lower() == 'y' then
            vim.pack.del { item.name }
            vim.notify(('Deleted %s'):format(item.name))
          end
        end)
      end,
    },
  }
end

return M
