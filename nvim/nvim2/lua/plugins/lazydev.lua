return {
  "folke/lazydev.nvim",
  dependencies = {
    {
      "justinsgithub/wezterm-types",
    },
  },
  opts = {
    library = {
      { path = "wezterm-types", mods = { "wezterm" } },
    },
  },
}
