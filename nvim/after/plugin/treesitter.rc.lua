local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = {},
  },
  -- ensure_installed = {
  --   "bash",
  --   "c",
  --   "c_sharp",
  --   "clojure",
  --   "cpp",
  --   "css",
  --   "dockerfile",
  --   "go",
  --   "graphql",
  --   "haskell",
  --   "html",
  --   "java",
  --   "javascript",
  --   "json",
  --   "lua",
  --   "markdown",
  --   "markdown_inline",
  --   "ocaml",
  --   "php",
  --   "python",
  --   "ruby",
  --   "rust",
  --   "sql",
  --   "terraform",
  --   "toml",
  --   "tsx",
  --   "typescript",
  --   "yaml",
  -- },
  endwise = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = "<C-s>",
      node_decremental = "<C-backspace>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        ["as"] = "@statement.outer",
        ["is"] = "@statement.inner",
        ["ab"] = "@block.outer",
        ["ib"] = "@block.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",
        ["ap"] = "@parameter.outer",
        ["ip"] = "@parameter.inner",
      },
      -- You can choose the select mode (default is charwise 'v')
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding xor succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      include_surrounding_whitespace = true,
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]b"] = "@block.outer",
        ["]l"] = "@loop.outer",
        ["]i"] = "@conditional.outer",
        ["]p"] = "@parameter.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
        ["]B"] = "@block.outer",
        ["]L"] = "@loop.outer",
        ["]I"] = "@conditional.outer",
        ["]P"] = "@parameter.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[b"] = "@block.outer",
        ["[l"] = "@loop.outer",
        ["[i"] = "@conditional.outer",
        ["[p"] = "@parameter.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
        ["[B"] = "@block.outer",
        ["[L"] = "@loop.outer",
        ["[I"] = "@conditional.outer",
        ["[P"] = "@parameter.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },
    lsp_interop = {
      enable = true,
      border = 'none',
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
  ignore_install = {},
  auto_install = true,
  sync_install = false,
  modules = {},
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
