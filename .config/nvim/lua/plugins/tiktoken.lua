return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = function(_, opts)
      -- LuaRocks 3.13 keeps dkjson in its vendor directory, but
      -- luarocks.nvim does not add that directory to package.path.
      local rocks = vim.fn.stdpath("data") .. "/lazy/luarocks.nvim/.rocks"
      package.path = package.path .. ";" .. rocks .. "/share/lua/5.1/luarocks/vendor/?.lua"
      require("luarocks-nvim").setup(opts)
    end,
    opts = {
      rocks = { "tiktoken_core" },
    },
  },
}
