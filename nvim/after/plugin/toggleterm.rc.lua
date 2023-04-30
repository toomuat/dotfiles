local status, terminal = pcall(require, "toggleterm")
if (not status) then return end

terminal.setup {
  open_mapping = [[<c-\>]],
}

-- local Terminal = require("toggleterm.terminal").Terminal
-- local lazygit = Terminal:new({
--   cmd = "lazygit",
--   direction = "float",
--   hidden = true
-- })

-- function _lazygit_toggle()
--   lazygit:toggle()
-- end

-- vim.keymap.set("n", "<A-d>", "<cmd>lua _lazygit_toggle()<CR>")
-- vim.keymap.set("t", "<A-d>", "<cmd>lua _lazygit_toggle()<CR>")
