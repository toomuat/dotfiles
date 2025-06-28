-- lspsaga.nvim: LSPのUIや操作性を強化する多機能プラグイン
-- コードアクション・リネーム・ドキュメント表示・診断ジャンプなどを便利に
-- https://github.com/nvimdev/lspsaga.nvim

return {
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next Diagnostic" },
      { "gd", "<Cmd>Lspsaga finder<CR>", desc = "Find References" },
      { "ga", "<Cmd>Lspsaga code_action<CR>", mode = { "n", "v" }, desc = "Code Action" },
      { "gp", "<Cmd>Lspsaga peek_definition<CR>", desc = "Peek Definition" },
      { "gr", "<Cmd>Lspsaga rename<CR>", desc = "Rename" },
      { "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "Previous Diagnostic" },
      { "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "Next Diagnostic" },
      { "[E", function() require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Previous Error" },
      { "]E", function() require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Next Error" },
      { "K", "<Cmd>Lspsaga hover_doc<CR>", desc = "Hover Documentation" },
      { "<A-d>", "<Cmd>Lspsaga term_toggle<CR>", desc = "Toggle Terminal" },
    },
    opts = {
      ui = {
        border = "rounded",
        winblend = 0,
      },
      symbol_in_winbar = {
        enable = true,
        separator = " › ",
        hide_keyword = true,
        show_file = true,
        folder_level = 2,
      },
      lightbulb = {
        enable = true,
        enable_in_insert = false,
        sign = true,
        sign_priority = 40,
        virtual_text = false,
      },
      outline = {
        win_width = 30,
        auto_preview = true,
        keys = {
          expand_or_jump = "<CR>",
          quit = "q",
        },
      },
    },
  },
}
