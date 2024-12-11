-- Assuming you're using nvim-lspconfig for language server configuration
local nvim_lsp = require("lspconfig")

-- Setup Tailwind CSS Language Server
nvim_lsp.tailwindcss.setup({
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true, -- Enable snippet support
        },
      },
    },
  },
  settings = {
    tailwindCSS = {
      showPixelEquivalents = false,
      experimental = {
        classRegex = {
          'class: "(.*)"', -- This regex should match your usage
        },
      },
      includeLanguages = {
        rust = "html", -- Treat Rust files as HTML for class recognition
      },
    },
  },
  filetypes = {
    "rust", -- Add Rust to the supported filetypes
    "html", -- Ensure HTML is also included
  },
  init_options = {
    userLanguages = {
      rust = "html", -- Specify that Rust is treated as HTML
    },
  },
})

return {}
