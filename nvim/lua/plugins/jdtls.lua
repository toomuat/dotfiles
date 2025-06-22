-- nvim-jdtls: Java用LSPクライアント
-- omnisharp-extended-lsp.nvim: C#用LSP拡張
-- Javaファイルで自動起動、C#ファイルで自動起動
-- https://github.com/mfussenegger/nvim-jdtls
-- https://github.com/Hoffs/omnisharp-extended-lsp.nvim

return {
  {
    "Hoffs/omnisharp-extended-lsp.nvim",
    ft = "cs",
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },
}
