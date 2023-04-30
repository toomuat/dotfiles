local status, nvim_tree = pcall(require, "nvim-tree")
if (not status) then return end

vim.g["loaded_netrw"] = 1
vim.g["loaded_netrwPlugin"] = 1
vim.opt["termguicolors"] = true

nvim_tree.setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

vim.keymap.set("n", "<space>e", ":NvimTreeToggle<CR>")
-- vim.keymap.set("n", "<space>E", ":<C-u>Fern . -drawer -reveal=%<CR>")

