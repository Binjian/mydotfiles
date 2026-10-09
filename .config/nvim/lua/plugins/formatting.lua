return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        python = { "ruff_format" },
        json = { "prettier" },
        jsonc = { "prettier" },
        -- LazyVim changes large buffers to the "bigfile" filetype.
        bigfile = function(bufnr)
          local ft = vim.filetype.match({ filename = vim.api.nvim_buf_get_name(bufnr) })
          if ft == "json" or ft == "jsonc" then
            return { "prettier" }
          end
          return {}
        end,
      })
      local prettier = opts.formatters.prettier
      local condition = prettier.condition
      prettier.condition = function(self, ctx)
        if vim.bo[ctx.buf].filetype == "bigfile" then
          local ft = vim.filetype.match({ filename = ctx.filename })
          if ft == "json" or ft == "jsonc" then
            return true
          end
        end
        return not condition or condition(self, ctx)
      end
    end,
  },
}
