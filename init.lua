-- lazy nvim auto setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

vim.g.lazyvim_python_ruff = "ruff"

require("lazy").setup({

	spec = {
		{
			"LazyVim/LazyVim",
			import = "lazyvim.plugins",
			opts = {
				colorscheme = "tokyonight",
			},
		},
		{ import = "lazyvim.plugins.extras.dap.core" },
		{ import = "lazyvim.plugins.extras.test.core" },
		{ import = "lazyvim.plugins.extras.lang.python" },
	},
	opts = {
		servers = {},
	},
	{
		{
			"neovim/nvim-lspconfig",
			opts = {
				servers = {
					pyright = {
						mason = false,
						disableLanguageServices = true,
						reportMissingModuleSource = "none",
						reportMissingImports = "none",
						reportUndefinedVariable = "none",
						disableOrganizeImports = true,
					},
				},
			},
		},
		"williamboman/mason.nvim", -- LSP server installer
		"stsewd/isort.nvim",
		"nvim-treesitter/nvim-treesitter",
		"elentok/format-on-save.nvim",
		{
			"epwalsh/obsidian.nvim",
			version = "*",
			lazy = true,
			ft = "markdown",

			dependencies = {
				-- Required.
				"nvim-lua/plenary.nvim",

				-- see below for full list of optional dependencies 👇
			},
			opts = {
				workspaces = {
					{
						name = "notes",
						path = "~/notes",
					},
				},

				-- see below for full list of options 👇
			},
		},
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			dependencies = "nvim-treesitter/nvim-treesitter",
			after = "nvim-treesitter/nvim-treesitter",
			config = function()
				require("nvim-treesitter.configs").setup({
					textobjects = {
						select = {
							enable = true,
							lookahead = true,
							keymaps = {
								["af"] = "@function.outer",
								["if"] = "@function.inner",
								["ac"] = "@class.outer",
								["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
								["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
								-- Custom capture
								["aF"] = "@custom_capture",
							},
							selection_modes = {
								["@parameter.outer"] = "v", -- charwise
								["@function.outer"] = "V", -- linewise
								["@class.outer"] = "<c-v>", -- blockwise
							},
							include_surrounding_whitespace = true,
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
					},
				})
			end,
		},

		{
			"cameron-wags/rainbow_csv.nvim",
			config = true,
			ft = {
				"csv",
				"tsv",
				"csv_semicolon",
				"csv_whitespace",
				"csv_pipe",
				"rfc_csv",
				"rfc_semicolon",
			},
			cmd = {
				"RainbowDelim",
				"RainbowDelimSimple",
				"RainbowDelimQuoted",
				"RainbowMultiDelim",
			},
		},

		-- Looks
		-- "rebelot/kanagawa.nvim", -- Theme

		"elentok/format-on-save.nvim",
		-- "mfussenegger/nvim-dap",
		"folke/lazydev.nvim",
		"sharkdp/fd",
		{
			"X3eRo0/dired.nvim",
			dependencies = "MunifTanjim/nui.nvim",
			config = function()
				require("dired").setup({
					path_separator = "/",
					show_banner = true,
					show_icons = true,
					show_hidden = true,
					show_dot_dirs = true,
					show_colors = true,
				})
			end,
		},
		-- Autocompletion plugins
		"hrsh7th/nvim-cmp", -- Autocompletion plugin
		"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
		"hrsh7th/cmp-buffer", -- Buffer completions
		"hrsh7th/cmp-path", -- Path completions
		"hrsh7th/cmp-cmdline", -- Command-line completions
		-- "saadparwaiz1/cmp_luasnip", -- Snippet completions
		-- "L3MON4D3/LuaSnip", -- Snippets plugin

		-- Telescope
		"nvim-lua/plenary.nvim", -- Lua functions used by various plugins
		"ahmedkhalf/project.nvim",
		{
			"nvim-telescope/telescope.nvim", -- Fuzzy finder and more
			-- config = function()
			--   require("telescope.builtin").find_files { path_display = { "truncate" } }
			-- end
		},

		{
			"epwalsh/obsidian.nvim",
			version = "*", -- recommended, use latest release instead of latest commit
			lazy = true,
			ft = "markdown",
			dependencies = {
				-- Required.
				"nvim-lua/plenary.nvim",

				-- see below for full list of optional dependencies 👇
			},
			opts = {
				workspaces = {
					{
						name = "notes",
						path = "~/notes/",
					},
				},
			},
		},

		"tpope/vim-fugitive",

		--editing
		--put back surround\

		-- Looks
		-- "rebelot/kanagawa.nvim", -- Theme
		{
			-- Theme inspired by Atom
			"navarasu/onedark.nvim",
			priority = 1000,
			lazy = false,
			config = function()
				require("onedark").setup({
					-- Set a style preset. 'dark' is default.
					style = "dark", -- dark, darker, cool, deep, warm, warmer, light
					transparent = false,
				})
				require("onedark").load()
			end,
		},

		-- bindings
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			init = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 50
			end,
			opts = {},
		},
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
				},
			},
		},
	},
})
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
	vim.o.shell = "/c/Users/dylan.ritchings/dev/software/Git/usr/bin/bash.exe"
end

vim.g.lazydev_enabled = true

-- Basic settings
vim.o.timeout = true
vim.o.timeoutlen = 0
vim.opt.clipboard:append("unnamedplus")

vim.opt.relativenumber = true
vim.opt.number = true

vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.expandtab = true
vim.bo.softtabstop = 2
-- vim.g.python3_host_prog = vim.fn.system('pdm info --python').gsub('%s+', '')
vim.wo.conceallevel = 1
-- Keymap funcs
local function git_add_commit_push()
	local commit_message = vim.fn.input("Commit message: ")
	if commit_message == "" then
		print("Aborting commit due to empty commit message")
		return
	end
	vim.cmd(":Git add -u")
	vim.cmd(':Git commit -m "' .. commit_message .. '"')
	vim.cmd(":Git push")
end

local function ex_in_dir(func)
	return function()
		func({ cwd = vim.fn.expand("%:p:h") })
	end
end
-- Basic keymaps/bindings
local wk = require("which-key")
local ts = require("telescope.builtin")
wk.add({

	{ "<leader><cr>", ex_in_dir(ts.git_files), desc = "Search whole repo" },
	{ "<leader>.", ex_in_dir(ts.find_files), desc = "Search current dir" },
	{ "<leader>f", group = "file" },
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Search current dir" },
	{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
	{ "<leader>fd", "<cmd>Dired<cr>", desc = "Dired" },
	{ "<leader>fc", "<cmd>edit " .. vim.fn.stdpath("config") .. "/init.lua<cr>", desc = "Config" },
	{ "<leader>g", group = "git" },
	{ "<leader>ga", ":Git add -u<cr>", desc = "Add" },
	{ "<leader>gb", ":Git blame<cr>", desc = "Blame" },
	{ "<leader>gd", ":Git diff<cr>", desc = "Diff" },
	{ "<leader>gp", ":Git push<cr>", desc = "Push" },
	{ "<leader>gP", ":Git pull<cr>", desc = "Pull" },
	{ "<leader>gc", ":Git commit -m ", desc = "Commit" },
	{ "<leader>gs", ":Git status<cr>", desc = "Status" },
	{ "<leader>gq", "Quick push", desc = "Quick push" },
})

-- 	-- <cmd>lua ts.find_files({cwd = vim.fn.expand('%:p:h')})<cr>
-- 	-- TODO
-- 	-- - window movement, vert, hori, close...
-- 	-- - move buffer to seperate thing, close buf, recent files/buffs
-- 	-- - more file finding, current repo...
-- 	-- - git add this file, quick push remember last commit
-- 	-- telescope help
-- }, { prefix = "<leader>" })

require("telescope").setup({
	defaults = {
		path_display = { "smart" },
	},
})
-- LSP settings
local lspconfig = require("lspconfig")
-- Configure LSP
local on_attach = function(client, bufnr)
	if client.name == "ruff" then
		-- Disable hover in favor of Pyright
		client.server_capabilities.hoverProvider = false
	end
end

require("lspconfig").ruff.setup({
	on_attach = on_attach,
})

lspconfig.lua_ls.setup({})

-- Setup lspconfig with nvim-cmp capabilities
lspconfig.pyright.setup({
	autostart = false,
})
--
-- }
-- vim.lsp.set_log_level("debug")
lspconfig.pylsp.setup({})
local cmp = require("cmp")
-- local luasnip = require("luasnip")

-- format on save
-- local format_on_save = require("format-on-save")
-- local formatters = require("format-on-save.formatters")

-- format_on_save.setup({
-- 	exclude_path_patterns = {
-- 		"/node_modules/",
-- 		".local/share/nvim/lazy",
-- 	},
-- 	formatter_by_ft = {
-- 		python = formatters.lsp,
-- 		lua = formatters.lsp,
-- 	},
-- })

-- Setup nvim-cmp
cmp.setup({
	-- snippet = {
	-- 	expand = function(args)
	-- 		luasnip.lsp_expand(args.body)
	-- 	end,
	-- },
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
})

-- compile latex on save
vim.api.nvim_create_augroup("AutoPdf", {})
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.tex",
	group = "AutoPdf",
	callback = function()
		vim.cmd([[!latexmk -pdf -pv -xelatex]])
	end,
})

vim.fn.system("pdm info --packages")

-- Scroll down half a screen and keep cursor in the middle
vim.api.nvim_set_keymap("n", "<C-D>", "<C-D>zz", { noremap = true, silent = true })

-- Scroll up half a screen and keep cursor in the middle
vim.api.nvim_set_keymap("n", "<C-U>", "<C-U>zz", { noremap = true, silent = true })

-- Enable line wrapping
vim.wo.wrap = true

-- Preserve indentation when wrapping lines
vim.wo.breakindent = true

-- Specify a string to be displayed at the start of wrapped lines
vim.opt.showbreak = ">> "

-- Avoid breaking words when wrapping lines
vim.opt.linebreak = true
