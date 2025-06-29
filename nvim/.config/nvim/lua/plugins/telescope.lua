-- telescope.nvim: ファジー検索やファイル/バッファ/履歴/ヘルプなどを強力に検索できるプラグイン
-- <leader>ff でファイル検索、<leader>fg でGrep、<leader>fb でバッファ一覧など
-- https://github.com/nvim-telescope/telescope.nvim

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
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "ファイル検索" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep検索" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "バッファ一覧" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "ヘルプタグ検索" },
			{ "<leader>sf", "<cmd>Telescope file_browser<cr>", desc = "ファイルブラウザ" },
			-- Custom keymaps
			{
				";a",
				function()
					require("telescope.builtin").oldfiles({ initial_mode = "normal" })
				end,
				desc = "最近使ったファイル",
			},
			{
				";b",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find({
						theme = "dropdown",
						sorting_strategy = "ascending",
					})
				end,
				desc = "現在バッファ内ファジー検索",
			},
			{
				";f",
				function()
					require("telescope.builtin").find_files({
						no_ignore = false,
						hidden = true,
						initial_mode = "normal",
					})
				end,
				desc = "ファイル検索(隠し含む)",
			},
			{
				";r",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Grep検索",
			},
			{
				"\\",
				function()
					require("telescope.builtin").buffers({ initial_mode = "normal" })
				end,
				desc = "バッファ一覧",
			},
			{
				";t",
				function()
					require("telescope.builtin").help_tags({ initial_mode = "normal" })
				end,
				desc = "ヘルプタグ検索",
			},
			{
				";;",
				function()
					require("telescope.builtin").resume({ initial_mode = "normal" })
				end,
				desc = "前回の検索を再開",
			},
			{
				";e",
				function()
					require("telescope.builtin").diagnostics({ initial_mode = "normal" })
				end,
				desc = "診断一覧",
			},
			{
				";c",
				function()
					require("telescope.builtin").git_commits({ initial_mode = "normal" })
				end,
				desc = "Gitコミット履歴",
			},
			{
				";d",
				function()
					require("telescope.builtin").git_status({ initial_mode = "normal" })
				end,
				desc = "Gitステータス",
			},
			{
				";h",
				function()
					require("telescope.builtin").command_history({ initial_mode = "normal" })
				end,
				desc = "コマンド履歴",
			},
			{
				";g",
				function()
					require("telescope").extensions.frecency.frecency({ initial_mode = "normal" })
				end,
				desc = "最近使ったファイル(頻度順)",
			},
			{
				"sf",
				function()
					local telescope = require("telescope")
					local function telescope_buffer_dir()
						return vim.fn.expand("%:p:h")
					end
					telescope.extensions.file_browser.file_browser({
						path = "%:p:h",
						cwd = telescope_buffer_dir(),
						respect_gitignore = false,
						hidden = true,
						grouped = true,
						previewer = false,
						initial_mode = "normal",
						layout_config = { height = 40 },
					})
				end,
				desc = "カレントディレクトリでファイルブラウザ",
			},
			{
				"<leader>sw",
				function()
					local word = vim.fn.expand("<cword>")
					require("telescope.builtin").live_grep({ default_text = word })
				end,
				desc = "カーソル下の単語をGrep検索",
			},
		},
		opts = function()
			return {
				defaults = {
					mappings = {
						n = {
							["q"] = require("telescope.actions").close,
						},
					},
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--glob",
						"!node_modules/*",
						"--glob",
						"!dist/*",
						"--glob",
						"!build/*",
						"--glob",
						"!target/*",
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
								["<C-w>"] = function()
									vim.cmd("normal vbd")
								end,
							},
							["n"] = {
								-- your custom normal mode mappings
								["N"] = require("telescope").extensions.file_browser.actions.create,
								["h"] = require("telescope").extensions.file_browser.actions.goto_parent_dir,
								["/"] = function()
									vim.cmd("startinsert")
								end,
							},
						},
					},
					-- workspaces = {
					--   -- keep insert mode after selection in the picker, default is false
					--   keep_insert = true,
					-- }
				},
			}
		end,
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("file_browser")
			telescope.load_extension("frecency")
		end,
	},
}
