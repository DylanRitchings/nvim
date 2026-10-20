return {
  {
    'hat0uma/csvview.nvim',
    ft = 'csv',
    config = function()
      require('csvview').setup({
        parser = {
          -- Delimiter auto-detection
          async = true,
          delimiter = {
            default = ',',
            ft = {
              tsv = '\t',
            },
          },
        },
        view = {
          -- Minimum and maximum column width
          min_column_width = 5,
          spacing = 2,
          -- Display method: 'highlight' or 'border'
          display_mode = 'border',
        },
      })
      
      -- Set up autocommands for CSV files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "csv",
        callback = function()
          -- Disable line wrapping to prevent cascading
          vim.opt_local.wrap = false
          
          -- Enable horizontal scrolling
          vim.opt_local.sidescroll = 1
          vim.opt_local.sidescrolloff = 5
          
          -- Show column number in statusline
          vim.opt_local.ruler = true
          
          -- Optional: set a wider display for better viewing
          vim.opt_local.colorcolumn = ""
        end,
      })
    end,
  }
}
