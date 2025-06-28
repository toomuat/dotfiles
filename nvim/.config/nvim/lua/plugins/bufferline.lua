-- bufferline.nvim: バッファ（タブ）を見やすく表示・管理するプラグイン
-- <leader>bp でピン留め、<leader>bP で非ピン留めバッファを削除
-- LSP診断情報もバッファごとに表示
-- https://github.com/akinsho/bufferline.nvim

return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<C-n>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
      { "<C-p>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
    },
    opts = {
      options = {
        diagnostics = "none",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = require("lazyvim.config").icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
    },
  },
}
