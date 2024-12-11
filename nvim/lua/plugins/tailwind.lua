-- setup tailwindcss for dioxus
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local new = {
        server = {
          tailwindcss = {
            settings = {
              tailwindCSS = {
                experimental = {
                  classRegex = {
                    'class: "(.*)"',
                  },
                },
                includeLanguages = {
                  rust = "html",
                  eruby = "test",
                },
              },
            },
            filetypes = {
              "rust",
              "html",
              "typescriptreact",
            },
          },
        },
      }
      opts = vim.tbl_extend("force", opts, new)
      return opts
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    },
    opts = function(_, opts)
      print("function executed")
      opts.formatting = {
        format = require("tailwindcss-colorizer-cmp").formatter,
      }
    end,
  },
}
-- -- color the tailwindcssinline
-- {
--   "NvChad/nvim-colorizer.lua",
--   opts = {
--     user_default_options = {
--       tailwind = true,
--     },
--   },
-- }
