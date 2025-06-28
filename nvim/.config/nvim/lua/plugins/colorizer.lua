-- nvim-colorizer.lua: カラーコードをその場で色表示するプラグイン
-- ファイルを開くだけで自動的に有効化
-- https://github.com/norcalli/nvim-colorizer.lua

return {
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("colorizer").setup()
    end,
  },
}
