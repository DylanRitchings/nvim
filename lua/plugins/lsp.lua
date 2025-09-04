return {
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
  -- Recommended coc.nvim keybindings
  vim.keymap.set("n", "[g", '<Plug>(coc-diagnostic-prev)', { desc = "Go to previous diagnostic" })
  vim.keymap.set("n", "]g", '<Plug>(coc-diagnostic-next)', { desc = "Go to next diagnostic" })
  -- Only set coc.nvim keybindings for diagnostics, keep LSP for navigation/actions
      -- Unified coc.nvim keybindings and settings
      vim.keymap.set("n", "gD", ':call CocActionAsync("jumpDeclaration")<CR>', { desc = "Go to declaration" })
      vim.keymap.set("n", "gd", '<Plug>(coc-definition)', { desc = "Go to definition" })
      vim.keymap.set("n", "gi", '<Plug>(coc-implementation)', { desc = "Go to implementation" })
      vim.keymap.set("n", "gt", '<Plug>(coc-type-definition)', { desc = "Go to type definition" })
      vim.keymap.set("n", "gr", '<Plug>(coc-references)', { desc = "Find references" })
      vim.keymap.set("n", "gR", '<Plug>(coc-rename)', { desc = "Rename symbol" })
      vim.keymap.set("n", "gf", ':call CocActionAsync("format")<CR>', { desc = "Format buffer" })
      vim.keymap.set("n", "ga", ':CocAction<CR>', { desc = "Code action" })
      vim.keymap.set("n", "gh", ':call CocActionAsync("doHover")<CR>', { desc = "Hover documentation" })
      vim.keymap.set("n", "gs", ':call CocActionAsync("showSignatureHelp")<CR>', { desc = "Signature help" })
      vim.keymap.set("n", "gk", '<Plug>(coc-diagnostic-info)', { desc = "Show diagnostics" })
      vim.keymap.set("n", "gn", '<Plug>(coc-diagnostic-next)', { desc = "Next diagnostic" })
      vim.keymap.set("n", "gp", '<Plug>(coc-diagnostic-prev)', { desc = "Previous diagnostic" })
      vim.keymap.set("n", "gb", function()
        vim.cmd('normal! <C-o>')
      end, { desc = "Go back to previous location" })
      vim.cmd [[
        inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"
      ]]
      -- Basic config: show documentation on hover
    --   vim.cmd [[
    --     autocmd CursorHold * silent call CocActionAsync('doHover')
    --     autocmd User CocNvimInit ++once :CocInstall -sync coc-pyright coc-json coc-tsserver coc-lua coc-bash coc-yaml coc-html coc-css coc-markdown coc-powershell coc-docker coc-terraform coc-sql coc-vim | q
    --   ]]
    end,
  },
  "folke/neodev.nvim",
    -- "hrsh7th/cmp-nvim-lsp",
  {
    "williamboman/mason-lspconfig.nvim",
    version = "v1.32.0"
  },

  {
    "NoahTheDuke/vim-just",
    ft = "just",
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     { "folke/neodev.nvim", opts = {} },
  --     "williamboman/mason.nvim",
  --     "williamboman/mason-lspconfig.nvim",
  --   },
  --   opts = {
  --     servers = {
  --       pyright = {
  --         settings = {
  --           python = {
  --             analysis = {
  --               autoImportCompletions = true,
  --             },
  --           },
  --         },
  --       },
  --     },
  --   },
  --   config = function()
  --     local lspconfig = require("lspconfig")
  --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       pattern = "*",
  --       callback = function()
  --         vim.lsp.buf.format({ async = false })
  --       end,
  --     })
  --     local mason = require("mason")
  --     local mason_lspconfig = require("mason-lspconfig")
  --     -- Basic LSP setup
  --     local on_attach = function(client, bufnr)
  --       -- Go back to previous location
  --       local opts = { buffer = bufnr }
  --       -- LSP Navigation (all under 'g' prefix)
  --       vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
  --       vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
  --       vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "Go to implementation" })
  --       vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Go to type definition" })
  --       vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "Find references" })
  --       vim.keymap.set("n", "gR", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
  --       vim.keymap.set("n", "gf", function() vim.lsp.buf.format { async = true } end, { buffer = bufnr, desc = "Format buffer" })
  --       vim.keymap.set("n", "ga", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })
  --       vim.keymap.set("n", "gh", vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover documentation" })
  --       vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })
  --       vim.keymap.set("n", "gk", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show diagnostics" })
  --       vim.keymap.set("n", "gn", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Next diagnostic" })
  --       vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Previous diagnostic" })
  --       vim.keymap.set("n", "gb", function()
  --         vim.cmd('normal! <C-o>')
  --       end, { buffer = bufnr, desc = "Go back to previous location" })
  --     end
  --
  --     local capabilities = require("cmp_nvim_lsp").default_capabilities()
  --
  --     mason.setup()
  --     mason_lspconfig.setup({
  --       ensure_installed = {
  --         "lua_ls",
  --         -- "pyright",
  --         -- "black",
  --         -- "pylint",
  --         -- -- "ruff",
  --         -- "biome",
  --         -- "docker_compose_language_service",
  --         -- "dockerls",
  --         -- -- "hydra_lsp",
  --         -- -- "mypy",
  --         "terraformls",
  --         -- -- "black",
  --         -- -- "pylint",
  --         -- "ruff",
  --         -- "biome",
  --         -- "docker_compose_language_service",
  --         -- "dockerls",
  --         -- "hydra_lsp",
  --         -- "terraformls",
  --         -- "nil_ls",
  --         -- "rnix",
  --         -- "sqlls",
  --         -- "bashls",
  --         -- -- "harper_ls"
  --       },
  --       automatic_installation = true,
  --       automatic_enable = true,
  --     })
  --
  --     mason_lspconfig.setup_handlers({
  --       function(server_name)
  --         lspconfig[server_name].setup({
  --           on_attach = on_attach,
  --           capabilities = capabilities,
  --         })
  --       end,
  --     })
  --     lspconfig.lua_ls.setup({
  --       settings = {
  --         Lua = {
  --           completion = {
  --             callSnippet = "Replace"
  --           },
  --           diagnostics = {
  --             globals = { "vim" }
  --           },
  --           workspace = {
  --             library = vim.api.nvim_get_runtime_file("", true),
  --             checkThirdParty = false
  --           },
  --           telemetry = {
  --             enable = false,
  --           },
  --         },
  --       },
  --     })
  --     -- lspconfig.sourcekit.setup({
  --     --   cmd = { "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp" },
  --     --   root_dir = lspconfig.util.root_pattern("Package.swift", ".git"),
  --     --   -- ROOT_DIR = lspconfig.util.root_pattern(".git", "Package.swift", "compile_commands.json");
  --     --   capabilities = {
  --     --     workspace = {
  --     --       didChangeWatchedFiles = {
  --     --         dynamicRegistration = true,
  --     --       },
  --     --     },
  --     --   },
  --     -- })
  --   end,
  -- },
--   {
--     "hrsh7th/nvim-cmp",
--     dependencies = {
--       "hrsh7th/cmp-nvim-lsp",
--       "hrsh7th/cmp-nvim-lua",
--       "hrsh7th/cmp-buffer",
--       "hrsh7th/cmp-path",
--       "hrsh7th/cmp-cmdline",
--       "saadparwaiz1/cmp_luasnip",
--       "L3MON4D3/LuaSnip",
--     },
--     config = function()
--       local cmp = require("cmp")
--       local luasnip = require("luasnip")

--       cmp.setup({
--         snippet = {
--           expand = function(args)
--             luasnip.lsp_expand(args.body)
--           end,
--         },
--         mapping = cmp.mapping.preset.insert({
--           ["<C-n>"] = cmp.mapping.select_next_item(),
--           ["<C-p>"] = cmp.mapping.select_prev_item(),
--           ["<C-d>"] = cmp.mapping.scroll_docs(-4),
--           ["<C-f>"] = cmp.mapping.scroll_docs(4),
--           ["<C-Space>"] = cmp.mapping.complete(),
--           ["<C-e>"] = cmp.mapping.abort(),
--           ["<CR>"] = cmp.mapping.confirm({ select = true }),
--           ["<Down>"] = cmp.mapping.select_next_item(),
--           ["<Up>"] = cmp.mapping.select_prev_item(),
--           -- TODO shift enter new line without complete
--         }),
--         sources = cmp.config.sources({
--           { name = "nvim_lsp" },
--           { name = "luasnip" },
--           { name = "buffer" },
--           { name = "path" },
--         })
--       })
--     end,
--   },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      require("nvim-treesitter.install").prefer_git = false
      require("nvim-treesitter.install").compilers = { vim.fn.getenv('CC'), "cc", "gcc", "clang", "cl", "zig" }
      local data_dir = vim.fn.stdpath('data')
      configs.setup({
        ensure_installed = {
          "vim", "vimdoc", "query", "heex", "javascript", "html", "css",
          "python", "markdown", "markdown_inline", "bash", "powershell", "yaml", "org",
          "git_config", "git_rebase", "gitignore", "gitcommit", "gitattributes", "diff",
          "json", "make", "editorconfig", "hjson", "http" },
        auto_install = false,
        sync_install = true,
        ignore_install = {},
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },
}

-- let g:markdown_fenced_languages = ['html', 'python', 'lua', 'vim', 'typescript', 'javascript']
