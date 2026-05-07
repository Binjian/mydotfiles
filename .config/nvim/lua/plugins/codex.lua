return {
  "rhart92/codex.nvim",
  lazy = true,
  keys = {
    {
      "<leader>co",
      function()
        require("codex").open()
      end,
      desc = "Codex: Open",
      mode = "n",
    },
    {
      "<leader>cq",
      function()
        require("codex").close()
      end,
      desc = "Codex: Close",
      mode = "n",
    },
    {
      "<leader>cc",
      function()
        require("codex").toggle()
      end,
      desc = "Codex: Toggle",
      mode = { "n", "t" },
    },
    {
      "<leader>cs",
      function()
        require("codex").actions.send_selection()
      end,
      desc = "Codex: Send selection",
      mode = "v",
    },
  },
  opts = {
    split = "vertical",
    size = 0.3,
    codex_cmd = { "codex" },
    focus_after_send = false,
    log_level = "warn",
    autostart = false,
  },
  config = function(_, opts)
    require("codex").setup(opts)
  end,
}
