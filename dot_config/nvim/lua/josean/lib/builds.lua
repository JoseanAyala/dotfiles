local function capitalize_first_letter(str)
  return str:sub(1, 1):upper() .. str:sub(2)
end

local M = {}

function M.build_service(service)
  local title = capitalize_first_letter(service)

  local progress = require("fidget.progress")
  local handle = progress.handle.create({
    title = title,
    message = "",
    lsp_client = { name = "build" },
    percentage = nil,
  })

  local errs = {}
  local command = string.format("make dev-update-service SERVICE=%s", service)
  vim.fn.jobstart(command, {
    on_stderr = function(_, data, _)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(errs, line)
          end
        end
      end
    end,
    on_exit = function(_, code)
      handle:finish()
      if code ~= 0 then
        local err_message = table.concat(errs, "\n")

        -- Create error content with header
        local timestamp = os.date("%Y-%m-%d %H:%M:%S")
        local header = string.format("=== %s Build Failed ===\nTime: %s\nCommand: %s\n\n", title, timestamp, command)
        local content = header .. err_message

        -- Open in Snacks window
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(content, "\n"))
        vim.api.nvim_buf_set_option(buf, "filetype", "log")

        Snacks.win({
          buf = buf,
          title = string.format(" %s Build Error ", title),
          width = 0.8,
          height = 0.8,
          border = "rounded",
          keys = {
            q = "close",
          },
        })
      end
    end,
    detach = true,
  })
end

return M
