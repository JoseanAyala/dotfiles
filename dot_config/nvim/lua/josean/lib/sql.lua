local M = {}

local function get_db_url()
  local url = os.getenv("DB_URL")
  if not url or url == "" then
    vim.notify("DB_URL environment variable is not set", vim.log.levels.ERROR)
    return nil
  end
  return url
end

local function show_results(title, content, is_error)
  vim.schedule(function()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(content, "\n"))
    vim.api.nvim_buf_set_option(buf, "filetype", is_error and "log" or "sql")

    Snacks.win({
      buf = buf,
      title = is_error and string.format(" %s - Error ", title) or string.format(" %s ", title),
      width = 0.8,
      height = 0.8,
      border = "rounded",
      keys = {
        q = "close",
      },
    })
  end)
end

local function run_psql(args, title)
  local db_url = get_db_url()
  if not db_url then
    return
  end

  local progress = require("fidget.progress")
  local handle = progress.handle.create({
    title = title,
    message = "Running...",
    lsp_client = { name = "sql" },
    percentage = nil,
  })

  local stdout = {}
  local stderr = {}

  local cmd = vim.list_extend({ "psql", db_url }, args)

  vim.fn.jobstart(cmd, {
    on_stdout = function(_, data, _)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(stdout, line)
          end
        end
      end
    end,
    on_stderr = function(_, data, _)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(stderr, line)
          end
        end
      end
    end,
    on_exit = function(_, code)
      handle:finish()
      if code ~= 0 then
        local err_content = table.concat(stderr, "\n")
        show_results(title, err_content, true)
      else
        local result = table.concat(stdout, "\n")
        if result == "" then
          result = "(no results)"
        end
        show_results(title, result, false)
      end
    end,
  })
end

function M.run_file()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    vim.notify("No file in current buffer", vim.log.levels.ERROR)
    return
  end
  run_psql({ "-f", file }, "SQL File")
end

function M.run_selection()
  local start_line, end_line
  local mode = vim.fn.mode()
  if mode:match("[vV]") or mode == "\22" then
    start_line = vim.fn.getpos("v")[2]
    end_line = vim.fn.getpos(".")[2]
  else
    start_line = vim.fn.line("'<")
    end_line = vim.fn.line("'>")
  end
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local sql = table.concat(lines, "\n")
  if sql == "" then
    vim.notify("Empty selection", vim.log.levels.ERROR)
    return
  end
  run_psql({ "-c", sql }, "SQL Selection")
end

function M.run_query()
  vim.ui.input({ prompt = "SQL> " }, function(input)
    if not input or input == "" then
      return
    end
    run_psql({ "-c", input }, "SQL Query")
  end)
end

return M
