return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clojure_lsp = {},
      },
    },
  },
  -- Parinfer for automatic paren balancing
  {
    "gpanders/nvim-parinfer",
    ft = { "clojure", "fennel", "scheme", "lisp" },
  },
}
