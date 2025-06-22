-- nvim-ts-autotag: treesitter対応の自動タグ補完プラグイン
-- HTMLやJSXなどで自動的に閉じタグを補完
-- https://github.com/windwp/nvim-ts-autotag

return {
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    opts = {},
  },
}
