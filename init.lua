-- Packer.nvim configuration
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- LSP Configuration & Plugins
  use 'neovim/nvim-lspconfig'      -- Collection of configurations for built-in LSP client
  use 'williamboman/mason.nvim'    -- LSP server installer
  use 'nvim-treesitter/nvim-treesitter'
  use "elentok/format-on-save.nvim"

  -- Autocompletion plugins
  use 'hrsh7th/nvim-cmp'           -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'       -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-buffer'         -- Buffer completions
  use 'hrsh7th/cmp-path'           -- Path completions
  use 'hrsh7th/cmp-cmdline'        -- Command-line completions
  use 'saadparwaiz1/cmp_luasnip'   -- Snippet completions
  use 'L3MON4D3/LuaSnip'           -- Snippets plugin
  use 'mfussenegger/nvim-dap'  -- Debug Adapter Protocol plugin for Neovim

  -- Telescope
  use 'nvim-lua/plenary.nvim'      -- Lua functions used by various plugins
  use 'nvim-telescope/telescope.nvim' -- Fuzzy finder and more

  use 'tpope/vim-fugitive'

  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
      }
    end
}
end)


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
vim.g.mapleader = " "
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
    a = {":Git add -u<cr>", "Add"},
    b = {":Git blame<cr>", "Blame"},
    d = {":Git diff<cr>", "Diff"},
    c = {"", ""},
  }
}, { prefix = "<leader>" })

-- LSP settings
local lspconfig = require('lspconfig')

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
  },
})
-- Configure LSP
lspconfig.pyright.setup{}
lspconfig.lua_ls.setup{}

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
