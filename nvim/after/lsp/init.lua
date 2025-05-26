-- LSPの共通設定
local M = {}

-- 診断表示の設定
vim.diagnostic.config({
  virtual_text = {
    prefix = '●'
  },
  update_in_insert = false,
  float = {
    source = "always", -- Or "if_many"
  },
  severity_sort = true,
})

-- 診断アイコンの設定
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- CompletionItemKindのアイコン設定
vim.lsp.protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

-- 共通のon_attach関数
---@param client lsp.Client
---@param bufnr integer
M.on_attach = function(client, bufnr)
  -- tsseverの場合はフォーマッティングを無効化
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end

  -- キーマッピング
  local opts = { noremap = true, silent = true }
  vim.keymap.set('n', 'gj', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts) -- Use lspsaga
  -- vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)       -- Use lspsaga
  vim.keymap.set('n', '<space>f', '<cmd>lua vim.lsp.buf.format{ async = true }<CR>', opts)
  vim.keymap.set('n', 'gwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

  -- Format on save
  local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup_format,
      buffer = bufnr,
      callback = function() vim.lsp.buf.format({ async = false }) end
    })
  end
end

-- 共通のcapabilities設定
---@return lsp.ClientCapabilities
local function make_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local status_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
  if status_cmp_nvim_lsp then
    capabilities = cmp_nvim_lsp.default_capabilities()
  end
  return capabilities
end

-- 警告メッセージの抑制（null-lsから移行）
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end
    notify(msg, ...)
end

M.capabilities = make_capabilities()

return M
