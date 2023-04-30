local status, _ = pcall(require, "leap")
if (not status) then return end

vim.keymap.set({ "n", "x" }, "m", "<Plug>(leap-forward)")
vim.keymap.set({ "n", "x" }, "M", "<Plug>(leap-backward)")
vim.keymap.set({ "o" }, "z", "<Plug>(leap-forward)")
vim.keymap.set({ "o" }, "Z", "<Plug>(leap-backward)")
vim.keymap.set({ "o" }, "x", "<Plug>(leap-forward-x)")
vim.keymap.set({ "o" }, "X", "<Plug>(leap-backward-x)")
vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-cross-window)")
