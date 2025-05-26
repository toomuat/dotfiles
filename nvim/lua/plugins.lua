-- lazy.nvimの設定
return require("lazy").setup({
  -- カラースキーム
  {
    "svrana/neosolarized.nvim",
    dependencies = { "tjdevries/colorbuddy.nvim" }
  },

  -- ステータスライン
  { "hoob3rt/lualine.nvim" },

  -- LSP関連
  { "onsails/lspkind-nvim" },  -- vscode-like pictograms
  { "hrsh7th/cmp-buffer" },    -- nvim-cmp source for buffer words
  { "hrsh7th/cmp-nvim-lsp" },  -- nvim-cmp source for neovim's built-in LSP
  { "hrsh7th/nvim-cmp" },      -- Completion
  { "nvimdev/lspsaga.nvim" },   -- LSP UIs
  {
    "j-hui/fidget.nvim",       -- LSP progress
    tag = "legacy"
  },

  -- スニペット
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    build = ':TSUpdate',
  },
  { "RRethy/nvim-treesitter-endwise" },
  { "nvim-treesitter/nvim-treesitter-textobjects" },

  -- 自動ペア
  { "windwp/nvim-autopairs" },  -- {}, (), "" などのペア文字入力補完
  { "windwp/nvim-ts-autotag" }, -- nvim-treesitter の拡張プラグイン。HTMLタグの閉じタグ補完のため
  { "andymass/vim-matchup" },

  -- ユーティリティ
  { "nvim-lua/plenary.nvim" }, -- Common utilities

  -- Telescope
  { "nvim-telescope/telescope.nvim" },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "kkharji/sqlite.lua" },
  },
  { "nvim-telescope/telescope-frecency.nvim" },

  -- UI関連
  { "akinsho/nvim-bufferline.lua" },
  { "norcalli/nvim-colorizer.lua" },
  { "folke/zen-mode.nvim" },
  { "akinsho/toggleterm.nvim" },
  {
    'goolord/alpha-nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('alpha').setup(require('alpha.themes.startify').config)
    end
  },

  -- LSP拡張
  { 'nvimtools/none-ls.nvim' }, -- Fork of null-ls.nvim maintained by the community
  { "munifTanjim/prettier.nvim" },       -- Prettier plugin for Neovim's built-in LSP client
  { "williamboman/mason.nvim" },
  { "mfussenegger/nvim-jdtls" },
  {
    "scalameta/nvim-metals",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  -- Git
  -- { "lewis6991/gitsigns.nvim" },
  { "dinhhuy258/git.nvim" },
  { "akinsho/git-conflict.nvim" },
  -- { "pwntester/octo.nvim" }, -- Edit and review GitHub issues and pull requests

  -- モーション
  { "ggandor/leap.nvim" },
  { "tpope/vim-commentary" },
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },

  -- ファイラー
  { "lambdalisue/nerdfont.vim" },
  { "lambdalisue/glyph-palette.vim" },
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },

  -- Copilot
  { "github/copilot.vim" },

  -- コードランナー
  { "CRAG666/code_runner.nvim" },

  -- コメントアウトされたプラグイン
  -- { "kristijanhusak/defx-icons" },
  -- { "rmagatti/session-lens" },
  -- { "rmagatti/auto-session" },
  -- {
  --   "wfxr/minimap.vim",
  --   build = "cargo install --locked code-minimap",
  -- },
  -- { "is0n/jaq-nvim" }, -- Quickrun for Neovim
  -- { "hkupty/iron.nvim" }, -- Interactive REPL
  -- { "natecraddock/workspaces.nvim" },
}, {
  ui = {
    -- UIの境界線のスタイル
    border = "rounded",
    -- アイコン
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🔑",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
  -- インストールするプラグインの並び順
  install = {
    -- カラースキームを最初にインストール
    colorscheme = { "neosolarized" },
  },
  -- 自動チェックアップデートの頻度（日数）
  checker = {
    enabled = true,
    frequency = 7, -- 7日ごとにチェック
    notify = false, -- 通知を表示しない
  },
  -- パフォーマンス関連の設定
  performance = {
    rtp = {
      -- 無効化するプラグイン
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
