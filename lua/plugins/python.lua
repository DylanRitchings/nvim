
return {

  -- virtual environment management
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "microsoft/debugpy",
      "mfussenegger/nvim-dap",
    },
    -- branch = "regexp",
    lazy = true,
    opts = {
      stay_on_this_version = true,
      name = {
        ".venv",
        "venv",
        "env",
        ".env",
      },
      dap_enabled = true,
      auto_refresh = true,
    },
    keys = {
      { "<leader>cv", "<cmd>:venvselect<cr>", desc = "select virtualenv" },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "linux-cultist/venv-selector.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local venv = require("venv-selector")
      local python_path = venv.get_active_path()

      require("dap-python").setup(python_path)
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
    keys = {
      {
        "<leader>tb",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "toggle breakpoint",
      },
      {
        "<leader>tc",
        function()
          require("dap").continue()
        end,
        desc = "start/continue",
      },
      {
        "<leader>ti",
        function()
          require("dap").step_into()
        end,
        desc = "step into",
      },
      {
        "<leader>to",
        function()
          require("dap").step_over()
        end,
        desc = "step over",
      },
    },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/fixcursorhold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python"
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justmycode = true },
            args = { "--log-level", "debug" },
            -- python = function()
            --   return require("venv-selector").get_active_path()
            -- end,
            pytest_discover_instances = true,
            runner = "pytest"
          }),
        },
      })
    end,
    keys = {
      {
        "<leader>tt",
        function()
          require("neotest").run.run()
        end,
        desc = "run nearest test",
      },
      {
        "<leader>td",
        function()
          require("neotest").run.run({ strategy = 'dap' })
        end,
        desc = "debug nearest test",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "run current file",
      },
      {
        "<leader>ta",
        function()
          require("neotest").run.attach()
        end,
        desc = "test attach",
      },
      {
        "<leader>tw",
        function()
          require("neotest").watch.toggle(vim.fn.expand("%"))
        end,
        desc = "watch tests in file",
      },
    },
  },





}
