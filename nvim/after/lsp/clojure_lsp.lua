-- Clojure Language Server設定
local lsp_common = require("after/lsp")

---@type vim.lsp.Config
return {
  on_attach = lsp_common.on_attach,
  capabilities = lsp_common.capabilities,
}
