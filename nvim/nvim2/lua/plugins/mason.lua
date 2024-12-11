return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "ktlint",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = {
      kotlin = { "ktlint" },
    } },
  },
}
