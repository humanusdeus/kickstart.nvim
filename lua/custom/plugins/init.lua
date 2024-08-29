return {
	{
		"olrtg/nvim-emmet",
		config = function()
			vim.keymap.set({ "n", "v" }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
		end,
	},
	{
		'stevearc/oil.nvim',
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		config = function ()
			vim.cmd.colorscheme 'kanagawa-dragon'
			vim.cmd.hi 'Comment gui=none'
		end,
	},
	{
		'kristijanhusak/vim-dadbod-ui',
		dependencies = {
			{ 'tpope/vim-dadbod', lazy = true },
			{ 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
		},
		cmd = {
			'DBUI',
			'DBUIToggle',
			'DBUIAddConnection',
			'DBUIFindBuffer',
		},
		init = function()
			vim.g.db_ui_use_nerd_fonts = 1
			vim.g.dbs = {
				{ name = 'al-campo', url = 'postgresql://postgres.hmefmvttserybbkklutv:Iz4Ce0BJAgWEpz78@aws-0-us-west-1.pooler.supabase.com:6543/postgres' },
			}
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		build = ":Copilot auth",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
			filetypes = {
				markdown = true,
				help = true,
				yaml = true
			},
		},
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = "copilot.lua",
		opts = {},
	},
	{
		"nvim-lualine/lualine.nvim",
		optional = true,
		event = "VeryLazy",
		opts = function(_, opts)
			local colors = {
				[""] = vim.ui.fg("Special"),
				["Normal"] = vim.ui.fg("Special"),
				["Warning"] = vim.ui.fg("DiagnosticError"),
				["InProgress"] = vim.ui.fg("DiagnosticWarn"),
			}
			table.insert(opts.sections.lualine_x, 2, {
				function()
					local icon = vim.config.icons.kinds.Copilot
					local status = require("copilot.api").status.data
					return icon .. (status.message or "")
				end,
				cond = function()
					if not package.loaded["copilot"] then
						return
					end
					local ok, clients = pcall(vim.lsp.get_clients, { name = "copilot", bufnr = 0 })
					if not ok then
						return false
					end
					return ok and #clients > 0
				end,
				color = function()
					if not package.loaded["copilot"] then
						return
					end
					local status = require("copilot.api").status.data
					return colors[status.status] or colors[""]
				end,
			})
		end,
	},
}
