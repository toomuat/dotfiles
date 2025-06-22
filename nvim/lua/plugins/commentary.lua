return {
  {
    "tpope/vim-commentary",
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
      { "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
    },
    init = function()
      -- ノーマルモードで現在行のコメントをトグル
      vim.keymap.set("n", "gcc", "gc_", { remap = true, desc = "ノーマルモードで現在行をコメント/解除" })
    end,
  },
}
