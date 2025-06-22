local keymap = vim.keymap

keymap.set('i', 'jj', '<ESC>')
keymap.set('i', '<A-j>', '<DOWN>')
keymap.set('i', '<A-k>', '<UP>')
keymap.set('i', '<A-h>', '<LEFT>')
keymap.set('i', '<A-l>', '<RIGHT>')
keymap.set('i', '<A-i>', '<ESC>I')
keymap.set('i', '<A-a>', '<ESC>A')
keymap.set('i', '<A-o>', '<ESC>o')
keymap.set('i', '<A-S-o>', '<ESC>$O')
keymap.set('i', '<A-;>', '<ESC>$a;<ESC>')
keymap.set('n', '<A-j>', '5j')
keymap.set('n', '<A-k>', '5k')
keymap.set('n', 'j', 'gj')
keymap.set('n', 'k', 'gk')
keymap.set('n', 'p', ']p')
keymap.set('n', 'P', ']P')
keymap.set('n', 'x', '"_x')
keymap.set('n', 'zo', '<C-w>o', {desc = "-- Maximum current buffer"})
keymap.set('n', '<space><space>', ';', {desc = "; Jump to next mathcing character by using f"})
keymap.set('n', '<space>bd', ':bdelete<CR>')
keymap.set('n', '<space>w', ':w<CR>')
keymap.set('n', '<space>q', ':q<CR>')
keymap.set('n', '<space>x', ':x<CR>')
keymap.set('n', '<space>a', ':wqa<CR>')
keymap.set('n', '<space>sp', 'viwp', {desc = "viw: Select one word and paste"})
keymap.set('n', '<space>yw', 'viwy', {desc = "viwy: Yank one word"})
keymap.set('n', '<space>yp', 'vapyP')
keymap.set('n', '<space>yy', 'va{jo^')
keymap.set('n', '<space>t', '<C-w>T')
keymap.set('n', '<space>dd', ':w !diff % -<CR>', {desc = "Show changes from last save"})
keymap.set('t', '<Esc>', '<C-\\><C-n>')
keymap.set('t', 'jj', '<C-\\><C-n>')
keymap.set('t', '<A-h>', '<C-\\><C-N><C-w>h')
keymap.set('t', '<A-j>', '<C-\\><C-N><C-w>j')
keymap.set('t', '<A-k>', '<C-\\><C-N><C-w>k')
keymap.set('t', '<A-l>', '<C-\\><C-N><C-w>l')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwords
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- New tab
keymap.set('n', 'te', ':tabedit .<CR>', { silent = false })
keymap.set('n', 'tt', ':tabedit<CR>', { silent = false })

keymap.set('n', 's', '<Nop>')
-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
-- Move window
-- keymap.set('n', '<Space>', '<C-w>w')
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')
keymap.set('', 'sH', '<C-w>H')
keymap.set('', 'sK', '<C-w>K')
keymap.set('', 'sJ', '<C-w>J')
keymap.set('', 'sL', '<C-w>L')

-- Resize window
-- keymap.set('n', '<C-w><left>', '<C-w><')
-- keymap.set('n', '<C-w><right>', '<C-w>>')
-- keymap.set('n', '<C-w><up>', '<C-w>-')
-- keymap.set('n', '<C-w><down>', '<C-w>+')
keymap.set('n', '<A-.>', '<C-w>><C-w>><C-w>>')
keymap.set('n', '<A-,>', '<C-w><<C-w><<C-w><')
keymap.set('n', '+', '<C-w>+')
keymap.set('n', '=', '<C-w>-')
keymap.set('n', 's_', '<C-w>_')
keymap.set('n', 's|', '<C-w>|')
-- Maximize size of current buffer
keymap.set('n', 's+', '<C-w>|<C-w>_')
-- Equalize size of splitted buffers
keymap.set('', 's=', '<C-w>=')

keymap.set('', 'st', '<C-w>T')
