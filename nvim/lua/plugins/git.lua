-- このファイルはNeovim用Gitプラグインの設定です
-- プラグイン: dinhhuy258/git.nvim
-- 公式: https://github.com/dinhhuy258/git.nvim
-- 主な機能:
--   - Neovim上でGitのステージング、コミット、ブレーム表示などが可能
--   - ファイルを開く直前（BufReadPre）に自動で有効化
--   - optsで追加設定が可能（ここではデフォルト設定）

-- git.nvim: Git操作をNeovimから簡単に行うためのプラグイン
-- ファイル読み込み時に自動有効化

return {
  {
    "dinhhuy258/git.nvim",
    event = "BufReadPre",
    opts = {},
  },
}
