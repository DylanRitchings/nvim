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
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      },
      opts = {
       window = {
        position = "left",
        width = 40,
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ["<enter>"] = "open",
          -- ["<enter>"] = { 
            -- "toggle_node", 
            -- nowait = false, 
          -- },
          ["<space>"] = false  
        }
 
      },
      buffers = {
          follow_current_file = {
            enabled = true, 
            leave_dirs_open = false, 
        }
      },

      auto_open = false,
    }
  },
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   opts = {
  --     sort = {
  --       sorter = "case_sensitive",
  --     },
  --     view = {
  --       width = 30,
  --     },
  --     renderer = {
  --       group_empty = true,
  --     },
  --     filters = {
  --       dotfiles = true,
  --     },
  --   },
  -- },
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
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden" -- Add this to search hidden files
        },
      })
      
      opts.pickers = {
        find_files = {
          hidden = true -- This will allow find_files to show hidden files
        },
        live_grep = {
          additional_args = function()
            return {"--hidden"}
          end
        }
      }
  
      return opts
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  "nvim-telescope/telescope-fzf-native.nvim",
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
  },

  -- {
  --   "epwalsh/obsidian.nvim",
  --   version = "*",
  --   lazy = true,
  --   ft = "markdown",
  --
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   opts = {
  --     workspaces = {
  --       {
  --         name = "notes",
  --         path = "~/dev/notes",
  --       },
  --     },
  --   },
  -- },
  -- {
  --   "stevearc/conform.nvim",
  --   opts = {},
  --   config = function()
  --     require("conform").setup({
  --       formatters_by_ft = {
  --         lua = { "stylua" },
  --         -- Conform will run multiple formatters sequentially
  --         python = { "isort" },
  --       },
  --       format_on_save = {
  --         timeout_ms = 500,
  --         lsp_format = "fallback",
  --       },
  --     })
  --   end,
  -- },
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()

      require("mini.ai").setup()
      require("mini.basics").setup()
      require("mini.bufremove").setup()
      require("mini.comment").setup()
      require("mini.pairs").setup()
      require("mini.icons").setup()
      -- require("mini.surround").setup({
      -- mappings = {
      --   add = '<leader>sa',             -- Add surrounding in Normal and Visual modes
      --   delete = '<leader>sd',          -- Delete surrounding
      --   find = '<leader>sf',            -- Find surrounding (to the right)
      --   find_left = '<leader>sF',       -- Find surrounding (to the left)
      --   highlight = '<leader>sh',       -- Highlight surrounding
      --   replace = '<leader>sr',         -- Replace surrounding
      --   update_n_lines = '<leader>sn',  -- Update `n_lines`
      --
      --   suffix_last = 'l',      -- Suffix to search with "prev" method
      --   suffix_next = 'n',      -- Suffix to search with "next" method
      -- }
      -- })
      -- Add other mini modules you want to use
    end,
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      constrain_cursor = "name",
      delete_to_trash = true,
      default_file_explorer = true,

      lsp_file_methods = {
        enabled = true,
      },

      view_options = {
        show_hidden = true,
      },

      keymaps = {
        ["q"] = "actions.close",
        ["<BS>"] = "actions.parent",
        ["gx"] = "actions.open_external",
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
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {"nvim-treesitter/nvim-treesitter"}
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
      { "<leader>gL", "<cmd>Git log<CR>",                   desc = "Log" },
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
  {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup()
      end
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
        enabled = true,  -- if you want to enable the plugin
        message_template = " <author> • <summary> • <date>" , -- template for the blame message, check the Message template section for more options
        date_format = "%d-%m-%Y %H:%M:%S", -- template for the date, check Date format section for more options
        virtual_text_coklumn = 1,  -- virtual text start column, check Start virtual text at column section for more options
    },
    -- {
    --   "easymotion/vim-easymotion",
    --   opts = {
    --     EasyMotion_leader_key = '<Leader>',
    --     EasyMotion_use_upper = 1,
    --     EasyMotion_smartcase = 1,
    --     EasyMotion_use_smartsign_us = 1
    --   },
    -- }
    {
        'smoka7/hop.nvim',
        version = "*",
        opts = {
            keys = 'etovxqpdygfblzhckisuran'
        }
    },
    {
      "kevinhwang91/nvim-bqf"
    }
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- opts = {
    -- }
  },
  {"ahmedkhalf/project.nvim"}
}
