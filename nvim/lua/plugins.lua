local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use "wbthomason/packer.nvim"
  use {
    "svrana/neosolarized.nvim",
    requires = { "tjdevries/colorbuddy.nvim" }
  }
  use "hoob3rt/lualine.nvim" -- Statusline
  use "onsails/lspkind-nvim" -- vscode-like pictograms
  use "hrsh7th/cmp-buffer" -- nvim-cmp source for buffer words
  use "hrsh7th/cmp-nvim-lsp" -- nvim-cmp source for neovim's built-in LSP
  use "hrsh7th/nvim-cmp" -- Completion
  use "neovim/nvim-lspconfig" -- LSP
  use "glepnir/lspsaga.nvim" -- LSP UIs
  -- use {
  --   "glepnir/lspsaga.nvim", -- LSP UIs
  --   tag = "version_2.2",
  -- }
  use "j-hui/fidget.nvim" -- LSP progress
  use { "L3MON4D3/LuaSnip", opt = true } -- Snippets
  use { "saadparwaiz1/cmp_luasnip", opt = true }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use "RRethy/nvim-treesitter-endwise"
  use "nvim-treesitter/nvim-treesitter-textobjects"

  use "windwp/nvim-autopairs"
  use "windwp/nvim-ts-autotag"
  use "andymass/vim-matchup"

  use "nvim-lua/plenary.nvim" -- Common utilities
  -- use "kyazdani42/nvim-web-devicons" -- File icons
  use "nvim-telescope/telescope.nvim"
  -- use { "nvim-telescope/telescope.nvim", opt = true }
  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "kkharji/sqlite.lua" },
  }
  use "nvim-telescope/telescope-frecency.nvim"
  use "akinsho/nvim-bufferline.lua"
  use "norcalli/nvim-colorizer.lua"
  use "folke/zen-mode.nvim"
  use "akinsho/toggleterm.nvim"
  --  use "goolord/alpha-nvim"
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require 'alpha'.setup(require 'alpha.themes.startify'.config)
    end
  }

  -- LSP
  use 'jose-elias-alvarez/null-ls.nvim' -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
  use "munifTanjim/prettier.nvim" -- Prettier plugin for Neovim's built-in LSP client
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "simrat39/rust-tools.nvim"
  use "mfussenegger/nvim-jdtls"
  use {
    "scalameta/nvim-metals",
    requires = { "nvim-lua/plenary.nvim" }
  }

  use "lewis6991/gitsigns.nvim"
  use "dinhhuy258/git.nvim"
  use "akinsho/git-conflict.nvim"
  -- use "pwntester/octo.nvim" -- Edit and review GitHub issues and pull requests

  use "ggandor/leap.nvim" -- Motion
  use "tpope/vim-commentary"
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "tpope/vim-surround"
  use "tpope/vim-repeat"

  -- Filer
  use "lambdalisue/fern.vim"
  use "lambdalisue/nerdfont.vim"
  use "lambdalisue/fern-renderer-nerdfont.vim"
  use "lambdalisue/glyph-palette.vim"
  use "nvim-tree/nvim-tree.lua"
  use "nvim-tree/nvim-web-devicons"

  -- Session
  -- use "rmagatti/session-lens"
  -- use "rmagatti/auto-session"

  -- use "wfxr/minimap.vim"
  -- use {
  --   "wfxr/minimap.vim",
  --   run = "cargo install --locked code-minimap",
  --   -- cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
  --   -- config = function()
  --   --   vim.cmd("let g:minimap_width = 9")
  --   --   vim.cmd("let g:minimap_auto_start = 1")
  --   --   vim.cmd("let g:minimap_auto_start_win_enter = 1")
  --   -- end,
  -- }
  use "CRAG666/code_runner.nvim"
  -- use "is0n/jaq-nvim" -- Quickrun for Neovim
  -- use "hkupty/iron.nvim" -- Interactive REPL
  -- use "natecraddock/workspaces.nvim"
end)
