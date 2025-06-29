return {
  "github/copilot.vim",
  config = function()
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.keymap.set("i", "<C-l>", "copilot#Accept('<CR>')", { silent = true, expr = true, script = true, replace_keycodes = false })
    vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)")
    vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)")
    vim.keymap.set("i", "<C-o>", "<Plug>(copilot-dismiss)")
    vim.keymap.set("i", "<C-s>", "<Plug>(copilot-suggest)")
  end,
}
