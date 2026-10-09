return {
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>cf",
        function()
          local buf = vim.api.nvim_get_current_buf()
          local ft = vim.filetype.match({ filename = vim.api.nvim_buf_get_name(buf) })
          if vim.bo[buf].filetype ~= "bigfile" or (ft ~= "json" and ft ~= "jsonc") then
            LazyVim.format({ force = true })
            return
          end
          vim.notify("Formatting large JSON…", vim.log.levels.INFO, { title = "Format" })
          require("conform").format({ bufnr = buf, async = true, timeout_ms = 120000 }, function(err, changed)
            vim.schedule(function()
              if err then
                vim.notify(tostring(err), vim.log.levels.ERROR, { title = "Format" })
              else
                vim.notify(changed and "JSON formatted" or "JSON already formatted", vim.log.levels.INFO, { title = "Format" })
              end
            end)
          end)
        end,
        mode = { "n", "x" },
        desc = "Format",
      },
    },
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
