require("config.base")
require("config.highlights")
require("config.maps")
require("config.lazy")

-- -- プラグインパスをRTPに追加
-- local lspsaga_path = vim.fn.stdpath("data") .. "/lazy/lspsaga.nvim"
-- if vim.loop.fs_stat(lspsaga_path) then
--   vim.opt.rtp:prepend(lspsaga_path)
--   -- vim.notify("Added lspsaga to runtimepath: " .. lspsaga_path, vim.log.levels.INFO)
-- else
--   vim.notify("lspsaga path not found at: " .. lspsaga_path, vim.log.levels.WARN)
-- end

-- デバッグ情報レベルを設定
vim.lsp.set_log_level("debug")

-- lspモジュールをパスに追加
vim.opt.rtp:append(vim.fn.stdpath("config"))

local has = function(x)
  return vim.fn.has(x) == 1
end
local is_linux = has "linux"
local is_mac = has "mac"
local is_win = has "win32"

if is_linux then
  require("config.linux")
elseif is_mac then
  require("config.macos")
elseif is_win then
  require("config.windows")
end
