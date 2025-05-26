local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

-- Fix for "warning: multiple different client offset_encodings detected for buffer"
-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end
    notify(msg, ...)
end

null_ls.setup {
  on_init = function(new_client, _)
    new_client.offset_encoding = 'utf-8'
  end,
  sources = {
    -- Formatting
    null_ls.builtins.formatting.prettier.with({
      filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact", "html", "css", "scss", "yaml", "markdown", "json", "graphql" },
    }),
    null_ls.builtins.formatting.shfmt, -- shell script formatting
    null_ls.builtins.formatting.autopep8, -- python formatting

    -- Code actions
    null_ls.builtins.code_actions.shellcheck, -- shell script code actions

    -- Diagnostics
    null_ls.builtins.diagnostics.eslint.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
  },
  on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    --vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts) -- Use lspsaga
    --vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)       -- Use lspsaga
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
  end,
}
