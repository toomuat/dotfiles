-- Bash Language Server設定
local lsp_common = require(".init")

---@type vim.lsp.Config
return {
  cmd = { "bash-language-server", "start" },
  on_attach = lsp_common.on_attach,
  capabilities = lsp_common.capabilities,
}
