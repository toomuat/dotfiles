return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      "kkharji/sqlite.lua",
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>sf", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
      -- Custom keymaps
      { ";a", function() require("telescope.builtin").oldfiles({ initial_mode = "normal" }) end, desc = "Telescope builtin oldfiles" },
      { ";b", function() require("telescope.builtin").current_buffer_fuzzy_find({ theme = "dropdown", sorting_strategy = "ascending" }) end, desc = "Telescope builtin current_buffer_fuzzy_find" },
      { ";f", function() require("telescope.builtin").find_files({ no_ignore = false, hidden = true, initial_mode = "normal" }) end, desc = "Telescope builtin find_files" },
      { ";r", function() require("telescope.builtin").live_grep() end, desc = "Telescope builtin live_grep" },
      { "\\\\", function() require("telescope.builtin").buffers({ initial_mode = "normal" }) end, desc = "Telescope builtin buffers" },
      { ";t", function() require("telescope.builtin").help_tags({ initial_mode = "normal" }) end, desc = "Telescope builtin help_tags" },
      { ";;", function() require("telescope.builtin").resume({ initial_mode = "normal" }) end, desc = "Telescope builtin resume" },
      { ";e", function() require("telescope.builtin").diagnostics({ initial_mode = "normal" }) end, desc = "Telescope builtin diagnostics" },
      { ";c", function() require("telescope.builtin").git_commits({ initial_mode = "normal" }) end, desc = "Telescope builtin git_commits" },
      { ";d", function() require("telescope.builtin").git_status({ initial_mode = "normal" }) end, desc = "Telescope builtin git_status" },
      { ";h", function() require("telescope.builtin").command_history({ initial_mode = "normal" }) end, desc = "Telescope builtin command_history" },
      { ";g", function() require("telescope").extensions.frecency.frecency({ initial_mode = "normal" }) end, desc = "Telescope extensions frecency" },
      { "sf", function()
        local telescope = require("telescope")
        local function telescope_buffer_dir()
          return vim.fn.expand('%:p:h')
        end
        telescope.extensions.file_browser.file_browser({
          path = "%:p:h",
          cwd = telescope_buffer_dir(),
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "normal",
          layout_config = { height = 40 }
        })
      end, desc = "Telescope extensions file_browser" },
    },
    opts = function()
      local actions = require('telescope.actions')
      local fb_actions = require("telescope").extensions.file_browser.actions

      return {
        defaults = {
          mappings = {
            n = {
              ["q"] = actions.close
            },
          },
        },
        pickers = {
          find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
        extensions = {
          file_browser = {
            theme = "dropdown",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
              -- your custom insert mode mappings
              ["i"] = {
                ["<C-w>"] = function() vim.cmd('normal vbd') end,
              },
              ["n"] = {
                -- your custom normal mode mappings
                ["N"] = fb_actions.create,
                ["h"] = fb_actions.goto_parent_dir,
                ["/"] = function()
                  vim.cmd('startinsert')
                end
              },
            },
          },
          -- workspaces = {
          --   -- keep insert mode after selection in the picker, default is false
          --   keep_insert = true,
          -- }
        },
      }
    end,    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("file_browser")
      telescope.load_extension("frecency")
    end,
  },
}
