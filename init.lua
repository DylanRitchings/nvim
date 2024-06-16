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
--

vim.g.mapleader = " "

require("lazy").setup({
  -- LSP Configuration & Plugins
  'neovim/nvim-lspconfig',   -- Collection of configurations for built-in LSP client
  'williamboman/mason.nvim', -- LSP server installer
  'nvim-treesitter/nvim-treesitter',
  "elentok/format-on-save.nvim",
  'mfussenegger/nvim-dap',
  'folke/lazydev.nvim',

  -- Autocompletion plugins
  'hrsh7th/nvim-cmp',              -- Autocompletion plugin
  'hrsh7th/cmp-nvim-lsp',          -- LSP source for nvim-cmp
  'hrsh7th/cmp-buffer',            -- Buffer completions
  'hrsh7th/cmp-path',              -- Path completions
  'hrsh7th/cmp-cmdline',           -- Command-line completions
  'saadparwaiz1/cmp_luasnip',      -- Snippet completions
  'L3MON4D3/LuaSnip',              -- Snippets plugin
  -- Telescope
  'nvim-lua/plenary.nvim',         -- Lua functions used by various plugins
  'nvim-telescope/telescope.nvim', -- Fuzzy finder and more

  'tpope/vim-fugitive',

  --editing
  --put back surround
  -- theme
  "rebelot/kanagawa.nvim",
  -- bindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 50
    end,
    opts = {}
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
})


vim.g.lazydev_enabled = true

-- theme
vim.cmd('colorscheme kanagawa')


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

-- Basic keymaps
local wk = require("which-key")
wk.register({
  f = {
    name = "file",
    d = { "<cmd>Telescope find_files<cr>", "Find File dir" },
    g = { "<cmd>Telescope live_grep<cr>", "Grep" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
  },
  g = {
    name = "Git",
    a = { ":Git add -u<cr>", "Add" },
    b = { ":Git blame<cr>", "Blame" },
    d = { ":Git diff<cr>", "Diff" },
    c = { "", "" },
  }
}, { prefix = "<leader>" })

-- LSP settings
local lspconfig = require('lspconfig')

-- Configure LSP
lspconfig.pyright.setup {}
lspconfig.lua_ls.setup {}

local cmp = require('cmp')
local luasnip = require('luasnip')
-- format on save
local format_on_save = require("format-on-save")
local formatters = require("format-on-save.formatters")

format_on_save.setup({
  exclude_path_patterns = {
    "/node_modules/",
    ".local/share/nvim/lazy",
  },
  formatter_by_ft = {
    python = formatters.lsp,
    lua = formatters.lsp,
  },
})

-- Setup nvim-cmp
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Setup lspconfig with nvim-cmp capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.pyright.setup {
  capabilities = capabilities,
}

-- compile latex on save
vim.api.nvim_create_augroup('AutoPdf', {})
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.tex',
  group = 'AutoPdf',
  callback = function()
    vim.cmd([[!latexmk -pdf -pv -xelatex]])
  end,
})
