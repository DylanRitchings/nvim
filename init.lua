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

function GetPdmVenvPath()
	local handle = io.popen("pdm venv list | grep 'in-project' | awk '{print $3}'")
	local result = handle:read("*a")
	handle:close()

	-- Remove trailing newline
	result = result:gsub("[\n\r]", "")

	if result ~= "" then
		return result
	else
		return nil
	end
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

vim.g.lazyvim_python_lsp = "pylsp"
vim.g.lazyvim_python_ruff = "ruff"

-- local function get_pdm_python_path()
--   local handle = io.popen("pdm info --python")
--   if handle then
--     local result = handle:read("*a")
--     handle:close()
--     return result:gsub("%s+$", "") -- Trim any trailing whitespace
--   end
--   return nil
-- end

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
		opts = {
			adapters = {
				["neotest-python"] = {
					dap = { justMyCode = false },
					runner = "pytest",
					python = GetPdmVenvPath,
					args = { "--no-cov" },
					pytest_discover_instances = true,
					-- python = ".venv/bin/python",
				},
			},
			settings = {
				options = {
					notify_user_on_venv_activation = true,
				},
			},
		},
	},
	opts = {
		servers = {},
	},
	{
		{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
		"williamboman/mason.nvim", -- LSP server installer
		"stsewd/isort.nvim",
		-- {
		-- 	"mfussenegger/nvim-dap-python",
		-- 	config = function()
		-- 		-- Function to get the correct Python path
		--
		-- 		-- Setup nvim-dap-python with the correct Python path
		-- 		local path = GetPdmVenvPath()
		-- 		require("dap-python").setup(path .. "\\Scripts\\pythonw.exe")
		-- 		-- require("dap-python").setup(path)
		-- 		require("dap-python").test_runner = "pytest"
		--
		-- 		-- Debug prints to verify configuration
		-- 		print("Python path: " .. path)
		-- 		print("Test runner set to: " .. require("dap-python").test_runner)
		-- 		--
		-- 		-- -- Key mappings for debugging
		-- 		-- vim.keymap.set("n", "<leader>dtm", function()
		-- 		-- 	require("dap-python").test_method()
		-- 		-- end, { desc = "Debug Test Method" })
		-- 		-- vim.keymap.set("n", "<leader>dtc", function()
		-- 		-- 	require("dap-python").test_class()
		-- 		-- end, { desc = "Debug Test Class" })
		-- 		-- vim.keymap.set("n", "<leader>dtf", function()
		-- 		-- 	require("dap-python").test_file()
		-- 		-- end, { desc = "Debug Test File" })
		-- 	end,
		-- },
		--
		{
			"epwalsh/obsidian.nvim",
			version = "*",
			lazy = true,
			ft = "markdown",

			dependencies = {
				-- Required.
				"nvim-lua/plenary.nvim",
			},
			opts = {
				workspaces = {
					{
						name = "notes",
						path = "~/notes",
					},
				},
			},
		},
		"bullets-vim/bullets.vim",
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

		{
			"nvim-telescope/telescope-fzf-native.nvim",
			-- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		},

		-- Looks
		-- "rebelot/kanagawa.nvim", -- Theme

		"elentok/format-on-save.nvim",
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
		"tpope/vim-eunuch",
		-- Telescope
		"nvim-lua/plenary.nvim", -- Lua functions used by various plugins
		"ahmedkhalf/project.nvim",
		{
			"nvim-telescope/telescope.nvim", -- Fuzzy finder and more
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

		{
			-- Theme inspired by Atom
			"navarasu/onedark.nvim",
			priority = 1000,
			lazy = true,
			config = function()
				require("onedark").setup({
					style = "dark", -- dark, darker, cool, deep, warm, warmer, light
					transparent = true,
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
	vim.opt.shell = "bash"
	vim.opt.shellcmdflag = "-c"
	vim.opt.shellxquote = ""
	vim.opt.shellslash = true
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

function OpenExplorer()
	local current_dir = vim.fn.expand("%:p:h")
	local cmd = string.format('cd "%s" && explorer .', current_dir)
	print(cmd)
	vim.fn.jobstart(cmd, { detach = true })
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
	{ "<leader>fm", ":Move ", desc = "Move/Rename current file" },
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
	{ "<leader>dT", require("dap-python").test_method, desc = "Debug Test Method" },
	{ "<leader>o", group = "open" },
	{
		"<leader>oe",
		function()
			OpenExplorer()
		end,
		desc = "Open explorer",
	},
	{ "<leader>dd", "<cmd> lua vim.diagnostic.open_float() <CR>", desc = "Open float" },
})

require("telescope").setup({
	defaults = {
		path_display = { "smart" },
	},
})
-- LSP settings
local lspconfig = require("lspconfig")
-- Configure LSP
-- local on_attach = function(client, bufnr)
-- 	if client.name == "ruff" then
-- 		-- Disable hover in favor of Pyright
-- 		client.server_capabilities.hoverProvider = false
-- 	end
-- end

require("lspconfig").ruff.setup({
	on_attach = on_attach,
})

lspconfig.lua_ls.setup({})
lspconfig.pylsp.setup({})
local cmp = require("cmp")
-- local luasnip = require("luasnip")

-- Setup nvim-cmp
cmp.setup({
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

-- vim.fn.system("pdm info --packages")

-- Scroll down half a screen and keep cursor in the middle
vim.api.nvim_set_keymap("n", "<C-D>", "<C-D>zz", { noremap = true, silent = true })

-- Scroll up half a screen and keep cursor in the middle
vim.api.nvim_set_keymap("n", "<C-U>", "<C-U>zz", { noremap = true, silent = true })

-- Enable line wrapping
vim.wo.wrap = true
vim.o.wrap = true
-- Preserve indentation when wrapping lines
vim.wo.breakindent = true

-- Specify a string to be displayed at the start of wrapped lines
vim.opt.showbreak = ">> "

-- Avoid breaking words when wrapping lines
vim.opt.linebreak = true
vim.o.linebreak = true

-- vim.cmd("set verbosefile=~/.config/nvim/log")
-- vim.cmd("set verbose=15")
