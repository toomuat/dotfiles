-- Neovimのキーマッピング設定ファイル
-- ここでは主にインサートモード、ノーマルモード、ターミナルモード、ウィンドウ操作などのキーマップを定義しています

local keymap = vim.keymap

-- インサートモードのキーマップ
keymap.set('i', 'jj', '<ESC>', {desc = "インサートモードからノーマルモードへ"})
keymap.set('i', '<A-j>', '<DOWN>', {desc = "下に移動（インサートモード）"})
keymap.set('i', '<A-k>', '<UP>', {desc = "上に移動（インサートモード）"})
keymap.set('i', '<A-h>', '<LEFT>', {desc = "左に移動（インサートモード）"})
keymap.set('i', '<A-l>', '<RIGHT>', {desc = "右に移動（インサートモード）"})
keymap.set('i', '<A-i>', '<ESC>I', {desc = "行頭に移動（インサートモード）"})
keymap.set('i', '<A-a>', '<ESC>A', {desc = "行末に移動（インサートモード）"})
keymap.set('i', '<A-o>', '<ESC>o', {desc = "下に新しい行を挿入（インサートモード）"})
keymap.set('i', '<A-S-o>', '<ESC>$O', {desc = "上に新しい行を挿入（インサートモード）"})
keymap.set('i', '<A-;>', '<ESC>$a;<ESC>', {desc = "行末にセミコロンを追加（インサートモード）"})

-- ノーマルモードのキーマップ
keymap.set('n', '<A-j>', '5j', {desc = "5行下に移動（ノーマルモード）"})
keymap.set('n', '<A-k>', '5k', {desc = "5行上に移動（ノーマルモード）"})
keymap.set('n', 'j', 'gj', {desc = "表示上の下の行に移動"})
keymap.set('n', 'k', 'gk', {desc = "表示上の上の行に移動"})
keymap.set('n', 'p', ']p', {desc = "直後にペースト"})
keymap.set('n', 'P', ']P', {desc = "直前にペースト"})
keymap.set('n', 'x', '"_x', {desc = "削除してレジスタに入れない"})
keymap.set('n', 'zo', '<C-w>o', {desc = "現在のバッファを最大化"})
keymap.set('n', '<space><space>', ';', {desc = "fで次の文字にジャンプ"})
keymap.set('n', '<space>bd', ':bdelete<CR>', {desc = "バッファを削除"})
keymap.set('n', '<space>w', ':w<CR>', {desc = "保存"})
keymap.set('n', '<space>q', ':q<CR>', {desc = "終了"})
keymap.set('n', '<space>x', ':x<CR>', {desc = "保存して終了"})
keymap.set('n', '<space>a', ':wqa<CR>', {desc = "全て保存して終了"})
keymap.set('n', '<space>sp', 'viwp', {desc = "viw: 1単語選択して貼り付け"})
keymap.set('n', '<space>yw', 'viwy', {desc = "viwy: 1単語ヤンク"})
keymap.set('n', '<space>yp', 'vapyP', {desc = "パラグラフ全体をヤンクして貼り付け"})
keymap.set('n', '<space>yy', 'va{jo^', {desc = "ブロック全体をヤンク"})
keymap.set('n', '<space>t', '<C-w>T', {desc = "新しいタブで開く"})
keymap.set('n', '<space>dd', ':w !diff % -<CR>', {desc = "最後の保存からの差分を表示"})

-- ターミナルモードのキーマップ
keymap.set('t', '<Esc>', '<C-\\><C-n>', {desc = "ターミナルノーマルモードへ"})
keymap.set('t', 'jj', '<C-\\><C-n>', {desc = "ターミナルノーマルモードへ"})
keymap.set('t', '<A-h>', '<C-\\><C-N><C-w>h', {desc = "ターミナルで左ウィンドウへ"})
keymap.set('t', '<A-j>', '<C-\\><C-N><C-w>j', {desc = "ターミナルで下ウィンドウへ"})
keymap.set('t', '<A-k>', '<C-\\><C-N><C-w>k', {desc = "ターミナルで上ウィンドウへ"})
keymap.set('t', '<A-l>', '<C-\\><C-N><C-w>l', {desc = "ターミナルで右ウィンドウへ"})

-- 数値インクリメント/デクリメント
keymap.set("n", "+", "<C-a>", {desc = "数値をインクリメント"})
keymap.set("n", "-", "<C-x>", {desc = "数値をデクリメント"})

-- 単語削除（レジスタを汚さない）
keymap.set("n", "dw", 'vb"_d', {desc = "単語を後ろ向きに削除（レジスタを汚さない）"})

-- 全選択
keymap.set('n', '<C-a>', 'gg<S-v>G', {desc = "全選択"})

-- タブ操作
keymap.set('n', 'te', ':tabedit .<CR>', { silent = false, desc = "カレントディレクトリで新しいタブを開く" })
keymap.set('n', 'tt', ':tabedit<CR>', { silent = false, desc = "新しいタブを開く" })

-- sキー無効化とウィンドウ分割
keymap.set('n', 's', '<Nop>', {desc = "sキー無効化"})
keymap.set('n', 'ss', ':split<Return><C-w>w', {desc = "ウィンドウを横分割"})
keymap.set('n', 'sv', ':vsplit<Return><C-w>w', {desc = "ウィンドウを縦分割"})

-- ウィンドウ移動
keymap.set('', 'sh', '<C-w>h', {desc = "左ウィンドウへ移動"})
keymap.set('', 'sk', '<C-w>k', {desc = "上ウィンドウへ移動"})
keymap.set('', 'sj', '<C-w>j', {desc = "下ウィンドウへ移動"})
keymap.set('', 'sl', '<C-w>l', {desc = "右ウィンドウへ移動"})
keymap.set('', 'sH', '<C-w>H', {desc = "ウィンドウを最左へ移動"})
keymap.set('', 'sK', '<C-w>K', {desc = "ウィンドウを最上へ移動"})
keymap.set('', 'sJ', '<C-w>J', {desc = "ウィンドウを最下へ移動"})
keymap.set('', 'sL', '<C-w>L', {desc = "ウィンドウを最右へ移動"})

-- ウィンドウリサイズ
keymap.set('n', '<A-.>', '<C-w>><C-w>><C-w>>', {desc = "ウィンドウを右に大きくリサイズ"})
keymap.set('n', '<A-,>', '<C-w><<C-w><<C-w><', {desc = "ウィンドウを左に大きくリサイズ"})
keymap.set('n', '+', '<C-w>+', {desc = "ウィンドウを下にリサイズ"})
keymap.set('n', '=', '<C-w>-', {desc = "ウィンドウを上にリサイズ"})
keymap.set('n', 's_', '<C-w>_', {desc = "ウィンドウ高さ最大化"})
keymap.set('n', 's|', '<C-w>|', {desc = "ウィンドウ幅最大化"})
keymap.set('n', 's+', '<C-w>|<C-w>_', {desc = "ウィンドウ幅・高さ最大化"})
keymap.set('', 's=', '<C-w>=', {desc = "分割ウィンドウのサイズを等分"})
keymap.set('', 'st', '<C-w>T', {desc = "ウィンドウを新しいタブに移動"})
