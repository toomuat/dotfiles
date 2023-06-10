require("base")
require("highlights")
require("maps")
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
