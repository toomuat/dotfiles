vim.cmd("autocmd!")

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.wo.number = true

vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = "zsh"
vim.opt.backupskip = { "/tmp/*" }
vim.opt.inccommand = "split"
-- vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false         -- No wrap lines
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append { "**" } -- Finding files - Search down into subfolders
vim.opt.wildignore:append { "*/node_modules/*" }
vim.opt.mouse:append('a')
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.opt.relativenumber = true

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste"
})

-- Add asterisks in block comments
vim.opt.formatoptions:append { "r" }

vim.opt.fillchars = {
  horiz     = '━',
  horizup   = '┻',
  horizdown = '┳',
  vert      = '┃',
  vertleft  = '┫',
  vertright = '┣',
  verthoriz = '╋',
}
-- Global Statusline
vim.opt.laststatus = 3
--vim.api.nvim_set_hl(0, "VertSplit", {})
--vim.api.nvim_set_hl(0, "VertSplit", { ctermbg = 232, guifg = gray })

-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  pattern = { "*" },
  callback = function()
    vim.api.nvim_exec('silent! normal! g`"zv', false)
  end,
})

vim.api.nvim_exec([[
  autocmd FileType go setlocal expandtab
  autocmd FileType go setlocal shiftwidth=8
  autocmd FileType go setlocal softtabstop=8
  autocmd FileType go setlocal tabstop=8
]], false)
