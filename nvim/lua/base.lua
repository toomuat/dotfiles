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

-- パッケージの検索パスにLSP設定ディレクトリを追加
local lsp_path = vim.fn.stdpath("config") .. "/lsp"
package.path = package.path .. ";" .. lsp_path .. "/?.lua"
package.path = package.path .. ";" .. lsp_path .. "/?/init.lua"

-- LSPのデバッグログを有効化
vim.lsp.set_log_level("debug")

-- LSP関連のログファイルの場所を指定
local nvim_cache = vim.fn.stdpath('cache')
if vim.fn.isdirectory(nvim_cache) == 0 then
  vim.fn.mkdir(nvim_cache, 'p')
end
vim.env.NVIM_LSP_LOG_FILE = nvim_cache .. '/lsp.log'

-- デバッグ用にモジュールの読み込み状況を表示する関数
vim.api.nvim_create_user_command("CheckModule", function(opts)
  local module_name = opts.args
  if module_name == "" then
    print("Usage: CheckModule <module_name>")
    return
  end
  
  local status, result = pcall(require, module_name)
  if status then
    print("Successfully loaded module: " .. module_name)
    print("Result type: " .. type(result))
    if type(result) == "table" then
      print("Keys: " .. vim.inspect(vim.tbl_keys(result)))
    else
      print("Value: " .. tostring(result))
    end
  else
    print("Failed to load module: " .. module_name)
    print("Error: " .. tostring(result))
    
    -- 検索パスを表示
    print("\nLua search paths:")
    for path in string.gmatch(package.path, "[^;]+") do
      print("  " .. path)
    end
  end
end, {nargs = "?", desc = "Check if a Lua module can be loaded"})

-- LSP関連の設定を再読み込みするコマンド
vim.api.nvim_create_user_command("ReloadLSPConfig", function()
  local lsp_config_file = vim.fn.stdpath("config") .. "/lsp/init.lua"
  if vim.fn.filereadable(lsp_config_file) == 1 then
    dofile(lsp_config_file)
    print("Reloaded LSP config from " .. lsp_config_file)
  else
    print("LSP config file not found: " .. lsp_config_file)
  end
end, {desc = "Reload LSP configuration"})

-- updatetimeの設定
vim.opt.updatetime = 300

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
