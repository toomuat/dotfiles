-- none-ls.nvim: LSPのように外部フォーマッタやリンタを統合するプラグイン
-- mason.nvimと連携し、各種ツールを自動セットアップ
-- https://github.com/nvimtools/none-ls.nvim

return {
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local nls = require("null-ls")
      return {
        root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
        sources = {
          nls.builtins.formatting.fish_indent,
          nls.builtins.diagnostics.fish,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.prettier.with({
            filetypes = { "html", "json", "yaml", "markdown" },
          }),
        },
      }
    end,
  },
}
