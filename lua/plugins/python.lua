PYTHON_PATH = "C:\\Program Files\\Python312\\python.exe"
return {

  -- virtual environment management
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "microsoft/debugpy",
      "mfussenegger/nvim-dap",
    },
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

      -- Hatch venv scanning for venv-selector
      search_venv_managers = {
        hatch = {
          path = vim.fn.expand("~") .. "/Library/Caches/hatch/env/virtual",
          recursive = true,
        },
      },
    },
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "select virtualenv" },
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
      -- local venv = require("venv-selector")
      -- local python_path = venv.get_active_path()
      -- print(python_path)
      require("dap-python").setup(PYTHON_PATH)
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      -- dap.listeners.before.event_terminated["dapui_config"] = function()
      --   dapui.close()
      -- end
      -- dap.listeners.before.event_exited["dapui_config"] = function()
      --   dapui.close()
      -- end
    end,
    keys = {
      {
        "<leader>xb",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "toggle breakpoint",
      },
      {
        "<leader>xc",
        function()
          require("dap").continue()
        end,
        desc = "start/continue",
      },
      {
        "<leader>xi",
        function()
          require("dap").step_into()
        end,
        desc = "step into",
      },
      {
        "<leader>xo",
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
          python = {
            command = PYTHON_PATH
          },
          require("neotest-python")({
            dap = { justmycode = true },
              args = { "--log-level", "DEBUG"},
              -- pytest_discover_instances = true,
              runner = "pytest"
            }),
          },
        })
      end,
      -- keys = {
      --   {
      --     "<leader>xt",
      --     function()
      --       require("neotest").run.run()
      --     end,
      --     desc = "run nearest test",
      --   },
      --   -- {
      --   --   "<leader>xd",
      --   --   function()
      --   --     require("neotest").run.run({ strategy = 'dap' })
      --   --   end,
      --   --   desc = "debug nearest test",
      --   -- },
      --   -- {
      --   --   "<leader>xf",
      --   --   function()
      --   --     require("neotest").run.run(vim.fn.expand("%"))
      --   --   end,
      --   --   desc = "run current file",
      --   -- },
      --   {
      --     "<leader>xa",
      --     function()
      --       require("neotest").run.attach()
      --     end,
      --     desc = "test attach",
      --   },
      --   {
      --     "<leader>xw",
      --     function()
      --       require("neotest").watch.toggle(vim.fn.expand("%"))
      --     end,
      --     desc = "watch tests in file",
      --   },
      -- },
    },





  }
