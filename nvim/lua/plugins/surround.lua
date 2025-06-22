-- vim-surround プラグインの使い方
--
-- 例:
--   ys<motion><char>   : 指定範囲を<char>で囲む (例: ysiw")
--   cs<old><new>       : <old>で囲まれた部分を<new>に変更 (例: cs"')
--   ds<char>           : <char>で囲まれた部分を削除 (例: ds")
--   S (ビジュアル)     : 選択範囲を囲む
--
-- 詳細: https://github.com/tpope/vim-surround

return {
  {
    "tpope/vim-surround",
    keys = {
      { "cs", desc = "Change surrounding" },
      { "ds", desc = "Delete surrounding" },
      { "ys", desc = "Add surrounding" },
      { "yS", desc = "Add surrounding (new line)" },
      { "S", mode = "v", desc = "Surround selection" },
    },
  },
}
