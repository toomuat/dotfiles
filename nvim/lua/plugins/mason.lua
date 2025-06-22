return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "bash-language-server",
        "clangd",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "eslint_d",
        "lua-language-server",
        "pyright",
        "rust-analyzer",
        "tailwindcss-language-server",
        "terraform-ls",
        "typescript-language-server",
        "css-lsp",
        "html-lsp",
        "gopls",
        "prettier",
        "stylua",
        "shfmt",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    opts = {
      automatic_installation = true,
    },
  },
}
