return {
  "folke/lazy.nvim",
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local telescope = require("telescope")

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        path_display = { "truncate" },
        layout_config = {
          width = 0.95,
          height = 0.85,
        },
      })

      return opts
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  "nvim-telescope/telescope-fzf-native.nvim",
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",

    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "notes",
          path = "~/dev/notes",
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          python = { "isort", "black" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })
    end,
  },
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("mini.ai").setup()
      require("mini.basics").setup()
      require("mini.bufremove").setup()
      require("mini.comment").setup()
      require("mini.pairs").setup()
      require("mini.surround").setup()
      require("mini.icons").setup()
      -- Add other mini modules you want to use
    end,
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["q"] = "actions.close",
        ["<BS>"] = "actions.parent",
      },
    },
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },

    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      enabled = true,
    },
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
  },
  -- {
  -- 	"NeogitOrg/neogit",
  -- 	dependencies = {
  -- 		"nvim-lua/plenary.nvim", -- required
  -- 		"sindrets/diffview.nvim", -- optional - Diff integration
  --
  -- 		-- Only one of these is needed.
  -- 		"nvim-telescope/telescope.nvim", -- optional
  -- 		"ibhagwan/fzf-lua", -- optional
  -- 		"echasnovski/mini.pick", -- optional
  -- 	},
  -- 	config = true,
  -- },
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Git" },
    keys = {
      { "<leader>gs", ":Git<CR>",                           desc = "Git status" },
      { "<leader>gc", ":Git commit -a<CR>",                 desc = "Git commit" },
      { "<leader>gp", "<cmd>Git push<CR>",                  desc = "Push" },
      { "<leader>gP", "<cmd>Git pull<CR>",                  desc = "Pull" },
      { "<leader>gf", "<cmd>Git fetch<CR>",                 desc = "Fetch" },
      { "<leader>gb", "<cmd>Git branch<CR>",                desc = "Branch" },
      { "<leader>gB", "<cmd>Git blame<CR>",                 desc = "Blame" },
      { "<leader>gl", "<cmd>Git log<CR>",                   desc = "Log" },
      { "<leader>gr", "<cmd>Git rebase<CR>",                desc = "Rebase" },
      { "<leader>gd", "<cmd>Git diff<CR>",                  desc = "Diff" },
      { "<leader>gD", "<cmd>Git diff origin/main -- %<CR>", desc = "Diff with origin/main" },
      { "<leader>gS", "<cmd>Git stash<CR>",                 desc = "Stash" },
      { "<leader>gm", "<cmd>Git merge<CR>",                 desc = "Merge" },
      { "<leader>gC", "<cmd>Git cherry-pick<CR>",           desc = "Cherry Pick" },

    }
  },

  "nvim-tree/nvim-web-devicons",
  -- "lewis6991/gitsigns.nvim",
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "airblade/vim-gitgutter",
    event = "BufReadPre",
    config = function()
      -- Your vim-gitgutter configuration here
    end
  },
}
