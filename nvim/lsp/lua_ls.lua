-- Lua Language Server設定
local lsp_common = require(".init")

---@type vim.lsp.Config
return {
  on_attach = lsp_common.on_attach,
  capabilities = lsp_common.capabilities,
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
