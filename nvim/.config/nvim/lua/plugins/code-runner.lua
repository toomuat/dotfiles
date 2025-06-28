-- code_runner.nvim: ファイルやプロジェクトを簡単に実行できるプラグイン
-- <leader>r で現在ファイルを実行、<leader>rp でプロジェクト実行
-- 多言語対応、:RunCode などのコマンドも利用可能
-- https://github.com/CRAG666/code_runner.nvim

return {
  {
    "CRAG666/code_runner.nvim",
    cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
    keys = {
      { "<leader>r", "<cmd>RunCode<CR>", desc = "Run Code" },
      { "<leader>rf", "<cmd>RunFile<CR>", desc = "Run File" },
      { "<leader>rp", "<cmd>RunProject<CR>", desc = "Run Project" },
      { "<leader>rc", "<cmd>RunClose<CR>", desc = "Close Runner" },
    },
    opts = {
      mode = "term",
      filetype = {
        java = {
          "cd $dir &&",
          "javac $fileName &&",
          "java $fileNameWithoutExt"
        },
        python = "python3 -u",
        typescript = "deno run",
        rust = {
          "cd $dir &&",
          "rustc $fileName &&",
          "$dir/$fileNameWithoutExt"
        },
        go = "go run",
        javascript = "node",
        lua = "lua",
        sh = "bash",
      },
    },
  },
}
