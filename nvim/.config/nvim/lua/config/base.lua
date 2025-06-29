-- 基本的なVimコマンドの自動コマンドをクリア
vim.cmd("autocmd!")

-- 文字コード設定
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- 行番号を表示
vim.wo.number = true

-- エディタの基本動作設定
vim.opt.title = true -- タイトルを表示
vim.opt.autoindent = true -- 自動インデント
vim.opt.smartindent = true -- スマートインデント
vim.opt.hlsearch = true -- 検索時にハイライト
vim.opt.backup = false -- バックアップファイルを作らない
vim.opt.showcmd = true -- コマンドを表示
vim.opt.cmdheight = 1 -- コマンドラインの高さ
vim.opt.laststatus = 2 -- ステータスラインの表示
vim.opt.expandtab = true -- タブ入力時にスペースを使う
vim.opt.scrolloff = 10 -- スクロール時の余白
vim.opt.shell = "zsh" -- シェルをzshに設定
vim.opt.backupskip = { "/tmp/*" } -- バックアップ除外パス
vim.opt.inccommand = "split" -- インクリメンタルサーチの結果を分割表示
-- vim.opt.ignorecase = true -- 大文字小文字を無視した検索（必要に応じて有効化）
vim.opt.smarttab = true -- スマートタブ
vim.opt.breakindent = true -- 折り返し行のインデント維持
vim.opt.shiftwidth = 2 -- 自動インデント時の幅
vim.opt.tabstop = 2 -- タブ幅
vim.opt.wrap = false         -- 行の折り返しを無効化
vim.opt.backspace = { "start", "eol", "indent" } -- バックスペースの挙動
vim.opt.path:append { "**" } -- ファイル検索パスにサブフォルダを追加
vim.opt.wildignore:append { "*/node_modules/*" } -- node_modulesを無視
vim.opt.mouse:append('a') -- マウス操作を有効化
vim.opt.backup = false -- バックアップファイルを作らない
vim.opt.swapfile = false -- スワップファイルを作らない
vim.opt.signcolumn = "yes" -- サインカラムを常に表示
vim.opt.relativenumber = false -- 相対行番号を表示しない

-- Undercurl（下線装飾）の設定
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- 挿入モード終了時にペーストモードを自動で解除
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste"
})

-- ブロックコメントでアスタリスクを自動挿入
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

-- デバッグ用：Luaモジュールの読み込み状況を表示するコマンド
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

-- カーソルホールド等の応答性向上
vim.opt.updatetime = 300

-- ウィンドウ分割線などの装飾文字を設定
vim.opt.fillchars = {
  horiz     = '━',
  horizup   = '┻',
  horizdown = '┳',
  vert      = '┃',
  vertleft  = '┫',
  vertright = '┣',
  verthoriz = '╋',
}
-- グローバルステータスライン
vim.opt.laststatus = 3
--vim.api.nvim_set_hl(0, "VertSplit", {})
--vim.api.nvim_set_hl(0, "VertSplit", { ctermbg = 232, guifg = gray })

-- ファイル再読込時にカーソル位置を復元
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  pattern = { "*" },
  callback = function()
    vim.api.nvim_exec('silent! normal! g`"zv', false)
  end,
})

-- Goファイル用のインデント設定
vim.api.nvim_exec([[
  autocmd FileType go setlocal expandtab
  autocmd FileType go setlocal shiftwidth=8
  autocmd FileType go setlocal softtabstop=8
  autocmd FileType go setlocal tabstop=8
]], false)

-- leaderキーを<Space>に設定
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 永続的なアンドゥを有効にする
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
if vim.fn.isdirectory(vim.opt.undodir.value) == 0 then
  vim.fn.mkdir(vim.opt.undodir.value, "p")
end
