--local status, _ = pcall(require, "fern")
--if (not status) then return end
if (true) then return end

-- vim.g["fern#renderer"] = "nerdfont"

vim.keymap.set("n", "<space>e", ":<C-u>Fern . -drawer -toggle<CR>")
vim.keymap.set("n", "<space>E", ":<C-u>Fern . -drawer -reveal=%<CR>")

local _result = vim.api.nvim_exec([[
nnoremap <Plug>(fern-close-drawer) :<C-u>FernDo close -drawer -stay<CR>
nmap <buffer><silent> <Plug>(fern-action-open-and-close)
    \ <Plug>(fern-action-open)
    \ <Plug>(fern-close-drawer)
]], true)
print(_result)
