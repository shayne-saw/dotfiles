return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    opts = {               -- The `opts.opts` path is intetional
      log_level = "DEBUG", -- or "TRACE"
    },
  },
}
