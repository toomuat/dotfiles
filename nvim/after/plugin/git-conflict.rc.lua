-- this plugin cause error when using auto-session plugin
-- so disable tempolaly

-- local status, git = pcall(require, "git-conflict")
-- if (not status) then return end

-- git.setup(
--   {
--     default_mappings = false, -- disable buffer local mapping created by this plugin
--     disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
--     highlights = { -- They must have background color, otherwise the default color will be used
--       incoming = 'DiffText',
--       current = 'DiffAdd',
--     }
--   }
-- )

--[[
vim.keymap.set('n', 'co', '<Plug>(git-conflict-ours)')
vim.keymap.set('n', 'ct', '<Plug>(git-conflict-theirs)')
vim.keymap.set('n', 'cb', '<Plug>(git-conflict-both)')
vim.keymap.set('n', 'c0', '<Plug>(git-conflict-none)')
vim.keymap.set('n', ']x', '<Plug>(git-conflict-prev-conflict)')
vim.keymap.set('n', '[x', '<Plug>(git-conflict-next-conflict)')
]] --
