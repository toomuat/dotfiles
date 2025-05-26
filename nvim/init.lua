require("base")
require("highlights")
require("maps")

-- lazy.nvimのブートストラップコード
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- 最新の安定版を使用
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- プラグインパスをRTPに追加
local lspsaga_path = vim.fn.stdpath("data") .. "/lazy/lspsaga.nvim"
if vim.loop.fs_stat(lspsaga_path) then
  vim.opt.rtp:prepend(lspsaga_path)
  -- vim.notify("Added lspsaga to runtimepath: " .. lspsaga_path, vim.log.levels.INFO)
else
  vim.notify("lspsaga path not found at: " .. lspsaga_path, vim.log.levels.WARN)
end

-- デバッグ情報レベルを設定
vim.lsp.set_log_level("debug")

-- lspモジュールをパスに追加
vim.opt.rtp:append(vim.fn.stdpath("config"))

if not vim.g.vscode then
  require("plugins")
end

local has = function(x)
  return vim.fn.has(x) == 1
end
local is_linux = has "linux"
local is_mac = has "mac"
local is_win = has "win32"

if is_linux then
  require("linux")
elseif is_mac then
  require("macos")
elseif is_win then
  require("windows")
end
