local is_windows = vim.loop.os_uname().sysname == "Windows_NT"

-- Windows-only settings (CRLF, Git Bash shell, work paths) live in their own
-- file so they never apply on Mac or Linux.
if is_windows then
  require("config.windows")
end

ROOT_DIR = vim.fn.systemlist("git rev-parse --show-toplevel")[1]

-- Basic settings
vim.o.timeout = true
vim.o.timeoutlen = 400
vim.opt.clipboard:append("unnamedplus")
vim.g.neovide_input_macos_alt_is_meta = true
vim.g.editorconfig = false

-- -- Convert Unix line endings to DOS before save
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   group = vim.api.nvim_create_augroup("EnforceFileFormat", { clear = true }),
--   pattern = "*",
--   callback = function(ev)
--     if vim.bo[ev.buf].buftype == "" then
--       -- Get all lines in the buffer
--       local lines = vim.api.nvim_buf_get_lines(ev.buf, 0, -1, false)
--       -- Rewrite them back, which forces any format conversions
--       vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, lines)
--       -- Now set format and EOF flags
--       vim.bo[ev.buf].fileformat = "dos"
--       vim.bo[ev.buf].fixendofline = false
--       vim.bo[ev.buf].endofline = false
--     end
--   end,
-- })

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.wo.conceallevel = 1
vim.g.autoformat = true
vim.opt.mouse = 'a'
vim.g.lazydev_enabled = true

vim.env.GIT_WORK_TREE = vim.fn.getcwd()
vim.env.GIT_DIR = vim.fn.getcwd() .. "/.git"

vim.g.lazyvim_python_lsp = "pyright"


vim.g.loaded_python3_provider = nil

-- Enable line wrapping
vim.wo.wrap = true
vim.o.wrap = true
-- Preserve indentation when wrapping lines
vim.wo.breakindent = true

-- Specify a string to be displayed at the start of wrapped lines
vim.opt.showbreak = ">>"

-- Avoid breaking words when wrapping lines
vim.opt.linebreak = true
vim.o.linebreak = true

vim.filetype.add({
  extension = {
    ['http'] = 'http',
  },
})

-- Make quickfix editable
vim.api.nvim_create_autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('YOUR_GROUP_HERE', { clear = true }),
  desc = 'allow updating quickfix window',
  pattern = 'quickfix',
  callback = function(ctx)
    vim.bo.modifiable = true
    -- :vimgrep's quickfix window display format now includes start and end column (in vim and nvim) so adding 2nd format to match that
    vim.bo.errorformat = '%f|%l col %c| %m,%f|%l col %c-%k| %m'
    vim.keymap.set(
      'n',
      '<C-s>',
      '<Cmd>cgetbuffer|set nomodified|echo "quickfix/location list updated"<CR>',
      { buffer = true, desc = 'Update quickfix/location list with changes made in quickfix window' }
    )
  end,
})
--fix terraform and hcl comment string
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
  end,
  pattern = { "terraform", "hcl" },
})

vim.o.termguicolors = true -- Enable 24-bit RGB color

-- Filter out line-length diagnostics from any LSP
local orig_diagnostic_set = vim.diagnostic.set
vim.diagnostic.set = function(namespace, bufnr, diagnostics, opts)
  diagnostics = vim.tbl_filter(function(d)
    local msg = d.message:lower()
    return not (msg:match("line too long") or msg:match("line length") or msg:match("maximum line length") or msg:match("e501"))
  end, diagnostics)
  orig_diagnostic_set(namespace, bufnr, diagnostics, opts)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.wo.wrap = true
    local _in_table = false
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = 0,
      callback = function()
        local ok, node = pcall(vim.treesitter.get_node)
        if not ok or not node then return end
        local in_table = false
        local current = node
        while current do
          if current:type():match("table") then
            in_table = true
            break
          end
          current = current:parent()
        end
        if in_table ~= _in_table then
          _in_table = in_table
          vim.wo.wrap = not in_table
        end
      end,
    })
  end,
})
