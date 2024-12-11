return {
  "mrcjkb/rustaceanvim",
  opts = {
    server = {
      default_settings = {
        ["rust-analyzer"] = {
          inlayHints = {
            enable = false,
          },
        },
      },
    },
  },
}
