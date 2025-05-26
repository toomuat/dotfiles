local status, saga = pcall(require, "lspsaga")
if (not status) then
  print("Error loading lspsaga: " .. tostring(saga))
  return
end

saga.setup({
  ui = {
    border = "rounded",
    winblend = 0, -- 透明度 (0-100)
  },
  symbol_in_winbar = {
    enable = true,
    separator = " › ",
    hide_keyword = true,
    show_file = true,
    folder_level = 2,
  },
  lightbulb = {
    enable = true,
    enable_in_insert = false,
    sign = true,
    sign_priority = 40,
    virtual_text = false,
  },
  outline = {
    win_width = 30,
    auto_preview = true,
    keys = {
      expand_or_jump = "<CR>",
      quit = "q",
    },
  },
})

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

-- Toggle outline
vim.keymap.set("n", "<space>o", "<cmd>Lspsaga outline<CR>")

-- Hover Doc
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)

-- LSP Status check command
vim.api.nvim_create_user_command('LspStatus', function() 
  local clients = vim.lsp.get_active_clients()
  if #clients == 0 then
    vim.notify('No active LSP clients', vim.log.levels.WARN)
    return
  end
  
  local buf_clients = vim.lsp.get_clients({bufnr = 0})
  local buf_client_names = {}
  for _, client in ipairs(buf_clients) do
    table.insert(buf_client_names, client.name)
  end
  
  vim.notify('Active LSP clients:\n- For current buffer: ' .. table.concat(buf_client_names, ', ') .. 
             '\n- Total active: ' .. #clients, vim.log.levels.INFO)
  
  print(vim.inspect(clients))
end, {})

-- Show line diagnostics
vim.keymap.set("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

-- Show cursor diagnostic
vim.keymap.set("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)

-- Show buffer diagnostics
vim.keymap.set("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)

-- Call hierarchy
vim.keymap.set("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
vim.keymap.set("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

-- Floating terminal
vim.keymap.set({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
