-- nvim-autopairs プラグインの設定ファイル
-- Insertモードで自動ペア補完を有効化する
-- https://github.com/windwp/nvim-autopairs
return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
}
