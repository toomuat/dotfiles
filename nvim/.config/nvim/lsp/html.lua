-- HTML Language Server設定
local lsp_common = require(".init")

---@type vim.lsp.Config
return {
  on_attach = lsp_common.on_attach,
  capabilities = (function()
    local capabilities = vim.deepcopy(lsp_common.capabilities)
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return capabilities
  end)(),
}
