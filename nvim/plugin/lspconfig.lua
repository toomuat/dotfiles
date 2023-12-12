--vim.lsp.set_log_level("debug")

local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local protocol = require('vim.lsp.protocol')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.document_formatting = false
    -- client.resolved_capabilities.document_formatting = false
  end

  -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }
  vim.keymap.set('n', 'gj', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts) -- Use lspsaga
  --vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)       -- Use lspsaga
  vim.keymap.set('n', '<space>f', '<cmd>lua vim.lsp.buf.format{ async = true }<CR>', opts)
  vim.keymap.set('n', 'gwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.keymap.set('n', 'gl', '<cmd>lua print(vim.diagnostic.setloclist())<CR>', opts)

  --if client.server_capabilities.documentFormattingProvider then
  --  vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
  --  vim.api.nvim_create_autocmd("BufWritePre", {
  --    group = augroup_format,
  --    buffer = 0,
  --    callback = function() vim.lsp.buf.formatting_seq_sync() end
  --  })
  --end
end

protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
--local capabilities = require('cmp_nvim_lsp').update_capabilities(
--  vim.lsp.protocol.make_client_capabilities()
--)

nvim_lsp.flow.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx", "javascriptreact" },
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities
}

nvim_lsp.clangd.setup {
  on_attach = on_attach,
}

nvim_lsp.pyright.setup {
  on_attach = on_attach,
}

nvim_lsp.hls.setup {
  on_attach = on_attach,
  settings = {
    haskell = {
      cabalFormattingProvider = "cabalfmt",
      formattingProvider = "cabalfmt"
      -- formattingProvider = "ormolu"
    }
  }
}

nvim_lsp.jdtls.setup {
  on_attach = on_attach,
}

-- nvim_lsp.jsonls.setup {
--   on_attach = on_attach,
-- }

nvim_lsp.graphql.setup {
  on_attach = on_attach,
}

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
nvim_lsp.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.html.setup {
  on_attach = on_attach,
}

nvim_lsp.gopls.setup {
  on_attach = on_attach,
}

nvim_lsp.emmet_ls.setup {
  -- on_attach = on_attach,
}

nvim_lsp.terraformls.setup {
  on_attach = on_attach,
}

nvim_lsp.tflint.setup {
  on_attach = on_attach,
}

-- nvim_lsp.zls.setup {
--   on_attach = on_attach,
-- }

nvim_lsp.ruby_ls.setup {
  on_attach = on_attach,
}

nvim_lsp.ocamllsp.setup {
  on_attach = on_attach,
}

nvim_lsp.clojure_lsp.setup {
  on_attach = on_attach,
}

nvim_lsp.dockerls.setup {
  on_attach = on_attach,
}

-- nvim_lsp.bashls.setup {
--   on_attach = on_attach,
-- }

--nvim_lsp.rust_analyzer.setup {
--  on_attach = on_attach,
--  flags = lsp_flags,
--  settings = {
--    ["rust_analyzer"] = {}
--  }
--}
local options = {
  tools = {
    autoSetHints = true,
    inlay_hints = {
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },
  server = {
    on_attach = on_attach,
    settings = {
      ["rust_analyzer"] = {
        checkOnSave = {
          command = "clippy"
        },
      }
    }
  }
}
require('rust-tools').setup(options)

-- nvim_lsp.sourcekit.setup {
--   on_attach = on_attach,
-- }

-- nvim_lsp.sumneko_lua.setup {
nvim_lsp.lua_ls.setup {
  --filetypes = { "lua" },
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },

      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
    },
  },
}

nvim_lsp.tailwindcss.setup {}

nvim_lsp.erlangls.setup {
  on_attach = on_attach
}

nvim_lsp.metals.setup {
  on_attach = on_attach
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 4, prefix = "●" },
    severity_sort = true,
  }
)

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '●'
  },
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})
