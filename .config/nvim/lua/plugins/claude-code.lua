return {
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("claude-code").setup()
    end,
    --[[
    cmd = {
      "ClaudeCode",
      "ClaudeCodeContinue",
      "ClaudeCodeResume",
      "ClaudeCodeVerbose",
    },
    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code", mode = { "n", "t" } },
      { "<leader>aC", "<cmd>ClaudeCodeContinue<cr>", desc = "Continue Claude Code" },
      { "<leader>ar", "<cmd>ClaudeCodeResume<cr>", desc = "Resume Claude Code" },
      { "<leader>av", "<cmd>ClaudeCodeVerbose<cr>", desc = "Verbose Claude Code" },
    },
    opts = {
      window = {
        position = "float",
        float = {
          width = "85%",
          height = "85%",
          row = "center",
          col = "center",
          relative = "editor",
          border = "rounded",
        },
      },
      refresh = {
        enable = true,
        show_notifications = true,
      },
      git = {
        use_git_root = true,
      },
      keymaps = {
        toggle = {
          normal = false,
          terminal = false,
          variants = {
            continue = false,
            verbose = false,
          },
        },
        window_navigation = true,
        scrolling = true,
      },
    },
]]
  },
}
