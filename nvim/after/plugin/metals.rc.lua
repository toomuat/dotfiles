local status, metals = pcall(require, "metals")
-- if (not status) then return end
if (true) then return end
local metals_config = metals.bare_config()

-- Example configuration #39
-- https://github.com/scalameta/nvim-metals/discussions/39

metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  -- NOTE: You may or may not want java included here. You will need it if you
  -- want basic Java support but it may also conflict if you are using
  -- something like nvim-jdtls which also works on a java filetype autocmd.
  -- pattern = { "scala", "sbt", "java" },
  pattern = { "scala", "sbt" },
  callback = function()
    metals.initialize_or_attach(metals_config)

    --local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    ----Enable completion triggered by <c-x><c-o>
    --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true }
    vim.keymap.set('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    --vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts) -- Use lspsaga
    --vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)       -- Use lspsaga
    vim.keymap.set('n', '<space>f', '<cmd>lua vim.lsp.buf.format{ async = true }<CR>', opts)
    vim.keymap.set('n', 'gwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.keymap.set('n', 'gl', '<cmd>lua print(vim.diagnostic.setloclist())<CR>', opts)
  end,
  group = nvim_metals_group,
})
