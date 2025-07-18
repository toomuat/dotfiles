-- nvim-tree.lua: ファイルエクスプローラーをNeovimに追加するプラグイン
-- <space>e でトグル、<space>E でファイル検索
-- https://github.com/nvim-tree/nvim-tree.lua

return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCollapse" },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<space>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
      { "<space>E", "<cmd>NvimTreeFindFile<CR>", desc = "Find File in NvimTree" },
    },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    opts = {
      sort_by = "case_sensitive",
      view = {
        adaptive_size = true,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
        custom = { "^\\.git$" },
      },
      git = {
        ignore = true,
      },
    },
  },
}
