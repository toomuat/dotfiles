return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
      },
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        pyright = {},
        rust_analyzer = {},
        gopls = {},
        tsserver = {},
        html = {},
        cssls = {},
        tailwindcss = {},
        dockerls = {},
        terraformls = {},
        bashls = {},
      },
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")

      -- Diagnostics configuration
      vim.diagnostic.config(opts.diagnostics)

      -- LSP server setup
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- blink.cmp の capabilities を使用
      local has_blink, blink = pcall(require, "blink.cmp")
      if has_blink then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      for server, config in pairs(opts.servers) do
        config.capabilities = capabilities
        lspconfig[server].setup(config)
      end

      -- Global mappings
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set diagnostic loclist" })

      -- LSP attach autocmd
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts_buf = { buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts_buf)
          vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts_buf)
          vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts_buf)
          vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts_buf)
          vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts_buf)
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts_buf)
          vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts_buf)
          vim.keymap.set("n", "gR", vim.lsp.buf.references, opts_buf)
          vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts_buf)
        end,
      })
    end,
  },
}
