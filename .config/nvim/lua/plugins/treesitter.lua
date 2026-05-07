return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ninja",
        "rst",
        "bash",
        "html",
        "javascript",
        "latex",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      })
      opts.ensure_installed = vim.list.unique(opts.ensure_installed)
    end,
  },
}
