return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ninja",
        "rst",
        "bash",
        "css",
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
        "scss",
        "svelte",
        "typst",
        "tsx",
        "typescript",
        "vim",
        "vue",
        "yaml",
      })
      opts.ensure_installed = vim.list.unique(opts.ensure_installed)
    end,
  },
}
