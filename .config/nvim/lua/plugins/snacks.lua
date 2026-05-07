return {
  {
    "snacks.nvim",
    opts = {
      image = {
        force = true,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local ok, snacks = pcall(require, "snacks")
          if not ok then
            return
          end

          local function setup(name)
            local config = snacks.config[name]
            local mod = snacks[name]
            if not (config and config.enabled and mod) then
              return
            end
            if mod.setup then
              pcall(mod.setup)
            elseif mod.enable then
              pcall(mod.enable)
            end
          end

          setup("dashboard")
          setup("input")

          if snacks.config.notifier and snacks.config.notifier.enabled then
            vim.notify = snacks.notifier.notify
          end
        end,
      })
    end,
  },
}
