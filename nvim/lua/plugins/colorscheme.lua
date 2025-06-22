-- neosolarized.nvim: Solarized系カラースキームを提供するプラグイン
-- :colorscheme neosolarized で有効化
-- colorbuddy連携で細かな色調整も可能
-- https://github.com/svrana/neosolarized.nvim

return {
  {
    "svrana/neosolarized.nvim",
    dependencies = { "tjdevries/colorbuddy.nvim" },
    priority = 1000,
    config = function()
      local status, n = pcall(require, "neosolarized")
      if not status then return end

      n.setup({
        comment_italics = true,
      })

      vim.cmd("colorscheme neosolarized")

      local cb = require('colorbuddy.init')
      local Color = cb.Color
      local colors = cb.colors
      local Group = cb.Group
      local groups = cb.groups
      local styles = cb.styles

      Color.new('black', '#000000')
      Group.new('CursorLine', colors.none, colors.base03, styles.NONE, colors.base1)
      Group.new('CursorLineNr', colors.yellow, colors.black, styles.NONE, colors.base1)
      Group.new('Visual', colors.none, colors.base03, styles.reverse)
    end,
  },
}
