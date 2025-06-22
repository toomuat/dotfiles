-- lspkind.nvim: LSP補完メニューにアイコンや説明を追加するプラグイン
-- nvim-cmpや他の補完プラグインと連携して視認性向上
-- https://github.com/onsails/lspkind.nvim

return {
  {
    "onsails/lspkind.nvim",
    opts = {
      mode = "symbol_text",
      preset = "codicons",
      symbol_map = {
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "",
      },
    },
    config = function(_, opts)
      require("lspkind").init(opts)
    end,
  },
}
