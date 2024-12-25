return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "gh", vim.lsp.buf.hover }
    end,
    opts = {
      servers = {
        lua_ls = {
          -- single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                library = { vim.env.VIMRUNTIME },
              },
              misc = {
                -- parameters = { "--loglevel=trace" },
              },
              -- hover = { expandAlias = false },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {

                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
            },
          },
        },
        -- rust_analyzer = {
        --   inlayHints = {
        --     typeHints = { enable = false },
        --     chainingHints = { enable = false },
        --     parameterHints = { enable = false },
        --     closingBraceHints = { enable = false },
        --   },
        --   keys = {
        --     { "K", false },
        --     { "gh", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
        --   },
      },
      vtsls = {
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
      },
    },
    settings = {
      complete_function_calls = true,
      vtsls = {
        enableMoveToFileCodeAction = true,
        autoUseWorkspaceTsdk = true,
        experimental = {
          completion = {
            enableServerSideFuzzyMatch = true,
          },
        },
      },
      typescript = {
        updateImportsOnFileMove = { enabled = "always" },
        suggest = {
          completeFunctionCalls = true,
        },
        inlayHints = {
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          parameterNames = { enabled = "literals" },
          parameterTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = { enabled = false },
        },
      },
    },
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    opts = {
      tools = {
        open_split = "vertical",
      },
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>m", function()
            vim.cmd.RustLsp("expandMacro")
          end, { desc = "Expand Macro", buffer = bufnr })
          --   vim.keymap.set("n", "<leader>dr", function()
          --     vim.cmd.RustLsp("debuggables")
          --   end, { desc = "Rust Debuggables", buffer = bufnr })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            -- cargo = {
            --   allFeatures = true,
            --   loadOutDirsFromCheck = true,
            --   buildScripts = {
            --     enable = true,
            --   },
            -- },
            inlayHints = {
              enable = false,
              typeHints = { enable = false },
              chainingHints = { enable = false },
              parameterHints = { enable = false },
              closingBraceHints = { enable = false },
            },
            rustc = {
              source = "discover",
            },
          },
        },
      },
    },
  },
}
