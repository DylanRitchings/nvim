local function get_venv_in_repo_root()
  local util = require("lspconfig.util")
  local root = util.find_git_ancestor(vim.fn.getcwd())
  if root then
    local venv_path = root .. "/.venv"
    if vim.fn.isdirectory(venv_path) == 1 then
      return venv_path
    end
  end
  return nil
end
require("dap-python").setup(get_venv_in_repo_root() or vim.fn.exepath("python"))

return {

  -- Virtual environment management
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "microsoft/debugpy",
      "mfussenegger/nvim-dap",
    },
    -- branch = "regexp",
    opts = {
      stay_on_this_version = true,
      name = {
        "venv",
        ".venv",
        "env",
        ".env",
      },
      dap_enabled = true,
      auto_refresh = true,
    },
    keys = {
      { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" },
    },
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      {
        "<leader>tt",
        function()
          require("neotest").run.run()
        end,
        desc = "Run nearest test",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run current file",
      },
    },
  },



  -- Debugging
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
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Start/Continue",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
    },
  },

  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "python" },
    },
  },
}
