-- flash.nvim: 画面上の任意の文字へ一瞬でジャンプできる高速移動プラグイン
-- m/M で前方・後方ジャンプ、;/, でリピート、z/Z/x/X でoperator mode、gs でウィンドウ間ジャンプ
-- 使い方: m → 2文字入力 → ラベル選択でジャンプ → ; で次のマッチ、, で前のマッチ
-- operator例: dz → 2文字 → ラベル で指定位置まで削除
--            dx → 2文字 → ラベル で指定位置含めて削除
-- https://github.com/folke/flash.nvim

return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    {
      "m",
      mode = { "n", "x" },
      function()
        require("flash").jump()
      end,
      desc = "Flash Jump",
    },
    {
      "M",
      mode = { "n", "x" },
      function()
        require("flash").jump({ search = { forward = false } })
      end,
      desc = "Flash Jump Backward",
    },
    {
      "z",
      mode = "o",
      function()
        require("flash").jump()
      end,
      desc = "Flash Jump (operator)",
    },
    {
      "Z",
      mode = "o",
      function()
        require("flash").jump({ search = { forward = false } })
      end,
      desc = "Flash Jump Backward (operator)",
    },
    {
      "x",
      mode = "o",
      function()
        require("flash").jump({ search = { mode = "search", max_length = 0 } })
      end,
      desc = "Flash Jump X (operator)",
    },
    {
      "X",
      mode = "o",
      function()
        require("flash").jump({ search = { forward = false, mode = "search", max_length = 0 } })
      end,
      desc = "Flash Jump X Backward (operator)",
    },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
    {
      "R",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search",
    },
    {
      "<c-s>",
      mode = { "c" },
      function()
        require("flash").toggle()
      end,
      desc = "Toggle Flash Search",
    },
    {
      ";",
      mode = { "n", "x" },
      function()
        require("flash").jump({ continue = true })
      end,
      desc = "Continue Flash",
    },
    {
      ",",
      mode = { "n", "x" },
      function()
        require("flash").jump({ continue = true, search = { forward = false } })
      end,
      desc = "Continue Flash Backward",
    },
  },
}

