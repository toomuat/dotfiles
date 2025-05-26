-- goolord/alpha-nvim: a lua powered greeter like vim-startify / dashboard-nvim https://github.com/goolord/alpha-nvim
local status, alpha = pcall(require, "alpha")
if (not status) then return end

alpha.setup(
  require 'alpha.themes.startify'.config
)
