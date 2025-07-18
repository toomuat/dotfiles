-- LuaSnip: 高機能スニペットエンジン
-- VSCode形式のスニペットも利用可能
-- <Tab>でスニペット展開・ジャンプ
-- https://github.com/L3MON4D3/LuaSnip

return {
  {
    "L3MON4D3/LuaSnip",
    build = (not jit.os:find("Windows"))
      and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
      or nil,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },
}
