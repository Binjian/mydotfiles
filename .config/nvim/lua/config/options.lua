-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

do
  local function tree_sitter_works()
    vim.fn.system({ "tree-sitter", "--version" })
    return vim.v.shell_error == 0
  end

  if not tree_sitter_works() then
    for _, candidate in ipairs(vim.fn.glob("/d/.asdf/installs/nodejs/*/bin/tree-sitter", false, true)) do
      local dir = vim.fs.dirname(candidate)
      if vim.fn.executable(candidate) == 1 then
        vim.env.PATH = dir .. ":" .. (vim.env.PATH or "")
        break
      end
    end
  end
end

-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = "pyright"
-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"

-- Disable optional remote-plugin providers that are not used by this config.
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
