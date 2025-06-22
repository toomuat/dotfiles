return {
  {
    "tpope/vim-commentary",
    keys = {
      { "gc", mode = { "n", "v" }, desc = "Comment toggle linewise" },
      { "gb", mode = { "n", "v" }, desc = "Comment toggle blockwise" },
    },
    init = function()
      vim.keymap.set("n", "gcc", "gc_", { remap = true })
    end,
  },
}
