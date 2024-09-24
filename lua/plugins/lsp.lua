return {
  "folke/neodev.nvim",
  "hrsh7th/cmp-nvim-lsp",
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "folke/neodev.nvim", opts = {} },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                autoImportCompletions = true,
              },
            },
          },
        },
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")

      -- Basic LSP setup
      local on_attach = function(client, bufnr)
        -- Add your keymaps and other on_attach logic here
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "ruff",
          "biome",
          "docker_compose_language_service",
          "dockerls",
          "hydra_lsp",
          -- "terraformls",
          "sqlls",
          "bashls",
          -- "harper_ls"
        },
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            init_options = {
              timeout = 5000
            }
          })
        end,
      })
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace"
            },
            diagnostics = {
              globals = { "vim" }
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Down>"] = cmp.mapping.select_next_item(),
          ["<Up>"] = cmp.mapping.select_prev_item(),
          -- TODO shift enter new line without complete
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        })
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      require("nvim-treesitter.install").compilers = { "zig" }

      configs.setup({
        ensure_installed = {
          "lua", "vim", "vimdoc", "query", "heex", "javascript", "html", "css",
          "python", "markdown", "markdown_inline", "bash", "powershell", "yaml", "org",
          "git_config", "git_rebase", "gitignore", "gitcommit", "gitattributes", "diff",
          "json", "make", "editorconfig" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },

}

-- let g:markdown_fenced_languages = ['html', 'python', 'lua', 'vim', 'typescript', 'javascript']
