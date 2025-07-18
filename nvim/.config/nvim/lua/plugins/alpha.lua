-- alpha-nvim: Neovimのスタート画面をカスタマイズできるプラグイン
-- 起動時に便利なショートカットや最近使ったファイルを表示
-- https://github.com/goolord/alpha-nvim
-- Note: vim.validate deprecation warning is a known issue in alpha-nvim
-- Will be fixed when upstream updates to new API

return {
  "goolord/alpha-nvim",
  opts = function()
    local startify = require("alpha.themes.startify")
    return startify
  end,
  config = function(_, startify)
    require("alpha").setup(startify.opts)
  end,
}
