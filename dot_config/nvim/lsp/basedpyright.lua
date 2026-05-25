return {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'pyrightconfig.json', '.git' },
  before_init = function(_, config)
    local path = vim.fn.exepath 'python3' or vim.fn.exepath 'python' or 'python3'
    for _, venv_name in ipairs { '.venv', 'venv' } do
      local venv_path = vim.fs.joinpath(config.root_dir or vim.fn.getcwd(), venv_name)
      local bin = vim.fs.joinpath(venv_path, 'bin', 'python')
      if vim.uv.fs_stat(bin) then
        path = bin
        break
      end
    end
    config.settings = vim.tbl_deep_extend('force', config.settings or {}, {
      python = { pythonPath = path },
    })
  end,
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = 'basic',
        autoImportCompletions = true,
      },
    },
  },
}
