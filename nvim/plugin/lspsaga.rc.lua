local status, saga = pcall(require, "lspsaga")
if (not status) then return end

saga.setup {}

-- saga.init_lsp_saga {
--   -- when cursor in saga window you config these to move
--   move_in_saga = { prev = '<C-p>', next = '<C-n>' },
--   -- preview lines of lsp_finder and definition preview
--   max_preview_lines = 100,
--   -- definition_action_keys = {
--   --   edit = '<C-c>o',
--   --   vsplit = '<C-c>v',
--   --   split = '<C-c>i',
--   --   tabe = '<C-c>t',
--   --   quit = 'q',
--   -- },
-- }

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga finder<CR>', opts)
vim.keymap.set({ "n", "v" }, 'ga', '<Cmd>Lspsaga code_action<CR>', opts)
--vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)

-- Diagnsotic jump can use `<c-o>` to jump back
vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

-- Only jump to error
vim.keymap.set("n", "[E", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })
vim.keymap.set("n", "]E", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { silent = true })

-- Outline
-- vim.keymap.set("n", "<space>o", "<cmd>LSoutlineToggle<CR>", { silent = true })
-- Toggle outline
vim.keymap.set("n","<space>o", "<cmd>Lspsaga outline<CR>")

-- Hover Doc
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)

-- Show line diagnostics
vim.keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

-- Show cursor diagnostic
vim.keymap.set("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)

-- Show buffer diagnostics
vim.keymap.set("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)

-- Float terminal
-- vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm zsh<CR>", { silent = true })
-- open lazygit in lspsaga float terminal
-- vim.keymap.set("n", "<A-s>", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })
-- close floaterm
vim.keymap.set("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
vim.keymap.set("t", "<A-s>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })

-- Call hierarchy
vim.keymap.set("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
vim.keymap.set("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

-- Floating terminal
vim.keymap.set({"n", "t"}, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
