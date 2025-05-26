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

if not vim.g.vscode then
  require("plugins")
else
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
