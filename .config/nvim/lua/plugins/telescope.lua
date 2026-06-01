return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
      -- Find files including hidden
      { "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find Files (hidden)" },
      -- Live grep including hidden
      { "<leader>sg", "<cmd>Telescope live_grep hidden=true<cr>", desc = "Live Grep (hidden)" },
    },
    opts = {
      defaults = {
        -- Example: ignore .git folder but show other hidden files
        vimgrep_arguments = {
          "rg",
          "--hidden",
          "--glob",
          "!**/.git/*",
          -- ... other default args
        },

        pickers = {
          find_files = {
            hidden = true,
          },
        },
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },
}
