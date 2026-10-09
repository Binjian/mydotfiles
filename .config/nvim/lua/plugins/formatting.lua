return {
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>cf",
        function()
          local buf = vim.api.nvim_get_current_buf()
          local ft = vim.bo[buf].filetype
          if ft == "bigfile" then
            ft = vim.filetype.match({ filename = vim.api.nvim_buf_get_name(buf) })
          end
          if ft ~= "json" and ft ~= "jsonc" then
            LazyVim.format({ force = true })
            return
          end
          vim.notify("Formatting JSON…", vim.log.levels.INFO, { title = "Format" })
          require("conform").format({
            bufnr = buf,
            formatters = { "prettier" },
            lsp_format = "never",
            -- Format the entire JSON document even from visual mode.
            range = {
              start = { 1, 0 },
              ["end"] = {
                vim.api.nvim_buf_line_count(buf),
                #vim.api.nvim_buf_get_lines(buf, -2, -1, false)[1],
              },
            },
            async = true,
            timeout_ms = 120000,
          }, function(err, changed)
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
      opts.formatters = opts.formatters or {}
      opts.formatters.prettier = opts.formatters.prettier or {}
      local prettier = opts.formatters.prettier
      -- Expand JSON objects and arrays, including short arrays, on separate lines.
      local append_args = prettier.append_args
      prettier.append_args = function(self, ctx)
        local args = type(append_args) == "function" and append_args(self, ctx) or append_args or {}
        args = vim.deepcopy(args)
        local ft = vim.bo[ctx.buf].filetype
        if ft == "bigfile" then
          ft = vim.filetype.match({ filename = ctx.filename })
        end
        if ft == "json" or ft == "jsonc" then
          vim.list_extend(args, {
            "--parser", ft == "json" and "json-stringify" or "json",
            "--tab-width", "2", "--use-tabs", "false",
            -- JSONC needs a narrow width to expand short arrays while preserving comments.
            "--print-width", "1",
            -- Explicit formatting must also work for gitignored data files.
            "--ignore-path", "/dev/null",
          })
        end
        return args
      end
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
