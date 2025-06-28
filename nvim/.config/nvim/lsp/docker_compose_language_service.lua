-- Docker Compose Language Server設定
local lsp_common = require(".init")

---@type vim.lsp.Config
return {
  cmd = { "docker-compose-language-service", "--stdio" },
  on_attach = lsp_common.on_attach,
  capabilities = lsp_common.capabilities,
}
