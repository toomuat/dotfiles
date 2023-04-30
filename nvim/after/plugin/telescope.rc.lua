local status, telescope = pcall(require, "telescope")
if (not status) then return end
local actions = require('telescope.actions')
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local fb_actions = require "telescope".extensions.file_browser.actions

telescope.setup {
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

telescope.load_extension("file_browser")
telescope.load_extension("frecency")
-- telescope.load_extension("session-lens")
-- telescope.load_extension("workspaces")

vim.keymap.set('n', ';a', function()
  builtin.oldfiles({
    initial_mode = "normal"
  })
end, { desc = "Telescope builtin oldfiles" })
vim.keymap.set('n', ';b', function()
  builtin.current_buffer_fuzzy_find({
    theme = "dropdown",
    sorting_strategy = "ascending",
    -- layout_config = {
    --   prompt_position = "top"
    -- }
  })
end, { desc = "Telescope builtin current_buffer_fuzzy_find" })
vim.keymap.set('n', ';f', function()
  builtin.find_files({
    no_ignore = false,
    hidden = true,
    initial_mode = "normal"
  })
end, { desc = "Telescope builtin find_files" })
vim.keymap.set('n', ';r', function()
  builtin.live_grep()
end, { desc = "Telescope builtin live_grep" })
vim.keymap.set('n', '\\\\', function()
  builtin.buffers({
    initial_mode = "normal"
  })
end, { desc = "Telescope builtin buffers" })
vim.keymap.set('n', ';t', function()
  builtin.help_tags({
    initial_mode = "normal"
  })
end, { desc = "Telescope builtin help_tags" })
vim.keymap.set('n', ';;', function()
  builtin.resume({
    initial_mode = "normal"
  })
end, { desc = "Telescope builtin resume" })
vim.keymap.set('n', ';e', function()
  builtin.diagnostics({
    initial_mode = "normal"
  })
end, { desc = "Telescope builtin diagnostics" })
vim.keymap.set('n', ';c', function()
  builtin.git_commits({
    initial_mode = "normal"
  })
end, { desc = "Telescope builtin git_commits" })
vim.keymap.set('n', ';d', function()
  builtin.git_status({
    initial_mode = "normal"
  })
end, { desc = "Telescope builtin git_status" })
vim.keymap.set('n', ';h', function()
  builtin.command_history({
    initial_mode = "normal"
  })
end, { desc = "Telescope builtin command_history" })
vim.keymap.set('n', ';g', function()
  telescope.extensions.frecency.frecency({
    initial_mode = "normal",
  })
end, { desc = "Telescope extensions frecency" })
-- vim.keymap.set('n', ';j', function()
-- vim.keymap.set('n', ';k', function()
-- vim.keymap.set('n', ';l', function()
-- vim.keymap.set('n', ';w', function()
-- vim.keymap.set('n', ';q', function()
-- vim.keymap.set('n', ';v', function()
-- vim.keymap.set('n', ';n', function()

-- vim.keymap.set('n', ';s', "<CMD>Telescope session-lens search_session<CR>",
--   { desc = "Telescope session-lens search_session" })
-- vim.keymap.set('n', ';s', function()
--   telescope.extensions.session_lens.session_lens({})
--   -- telescope.extensions.session_lens.search_session({})
-- end)
--vim.keymap.set('n', ';g', ":Telescope frecency<CR>")
-- vim.keymap.set('n', ';w', '<Cmd>Telescope workspaces<CR>')
vim.keymap.set("n", "sf", function()
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
end, {desc = "Telescope extensions file_browser"})
