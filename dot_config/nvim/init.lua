require 'josean.options'

-- Load order is not stable; any cross-file dependency must `require` its dep explicitly.
local plugins_dir = vim.fn.stdpath 'config' .. '/lua/josean/plugins'
local files = vim.fn.readdir(plugins_dir, function(name)
  return name:match '%.lua$' and 1 or 0
end)
for _, file in ipairs(files) do
  local module = 'josean.plugins.' .. file:gsub('%.lua$', '')
  local ok, err = pcall(require, module)
  if not ok then
    vim.notify(string.format('Failed to load %s: %s', module, err), vim.log.levels.ERROR)
  end
end

require 'josean.keymaps'
require 'josean.autocmds'

-- vim: ts=2 sts=2 sw=2 et
