-- Terraform Language Server設定
local lsp_common = require(".init")

---@type vim.lsp.Config
return {
  on_attach = lsp_common.on_attach,
  capabilities = lsp_common.capabilities,
}
