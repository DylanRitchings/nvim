
return {
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true 
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      vim.g.copilot_enabled = false       
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, 
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = true,
      proxy = "http://webproxy-cloud.metoffice.gov.uk:8082",
      window = {
        layout = 'vertical', 
      },
    },
    -- cmd = { "CopilotChat", "CopilotChatFix", "CopilotChatExplain" },
    keys = {
      { "<leader>lc", ":CopilotChat<CR>", mode = { "n", "v" }, desc = "Copilot Chat" },
      { "<leader>lf", ":CopilotChatFix<CR>", mode = { "v" }, desc = "Copilot Fix" },
      { "<leader>le", ":CopilotChatExplain<CR>", mode = { "v" }, desc = "Copilot Explain" },
    },
  }
}
