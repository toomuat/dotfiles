local status, mason = pcall(require, "mason")
if (not status) then return end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

mason.setup({})

lspconfig.setup {
  ensure_installed = {
    "bashls",
    "clangd",
    "docker_compose_language_service",
    "dockerls",
    -- "eslint_d",
    "jdtls",
    "lua_ls",
    "pyright",
    "rust_analyzer",
    "tailwindcss",
    "terraformls",
    "tsserver",
  },
}
