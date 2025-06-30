-- leap.nvim: 画面上の任意の文字へ一瞬でジャンプできる高速移動プラグイン
-- m/M で前方・後方ジャンプ、z/Z/x/X でoperator mode、gs でウィンドウ間ジャンプ
-- 使い方: m → 2文字入力 → ラベル選択でジャンプ
-- operator例: dz → 2文字 → ラベル で指定位置まで削除
--            dx → 2文字 → ラベル で指定位置含めて削除
-- https://github.com/ggandor/leap.nvim

return {
  "ggandor/leap.nvim",
  enabled = true,
  keys = {
    { "m",  mode = { "n", "x" },      desc = "Leap Forward" },
    { "M",  mode = { "n", "x" },      desc = "Leap Backward" },
    { "z",  mode = { "o" },           desc = "Leap Forward (operator)" },
    { "Z",  mode = { "o" },           desc = "Leap Backward (operator)" },
    { "gs", mode = { "n", "x", "o" }, desc = "Leap Cross Window" },
  },
  config = function()
    local leap = require("leap")
    -- デフォルトマッピングを無効化
    leap.add_default_mappings(false)
    -- カスタムマッピングを設定
    vim.keymap.set({ "n", "x" }, "m", "<Plug>(leap-forward)")
    vim.keymap.set({ "n", "x" }, "M", "<Plug>(leap-backward)")
    vim.keymap.set({ "o" }, "z", "<Plug>(leap-forward)")
    vim.keymap.set({ "o" }, "Z", "<Plug>(leap-backward)")
    vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-cross-window)")
  end,
}
