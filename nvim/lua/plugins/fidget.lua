-- fidget.nvim: LSPの進捗や通知を表示するミニマルなUIプラグイン
-- LspAttachイベントで自動的に有効化
-- https://github.com/j-hui/fidget.nvim

return {
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },
}
