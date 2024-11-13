
-- Scroll down half a screen and keep cursor in the middle
vim.api.nvim_set_keymap("n", "<C-D>", "<C-D>zz", { noremap = true, silent = true })
-- Scroll up half a screen and keep cursor in the middle
vim.api.nvim_set_keymap("n", "<C-U>", "<C-U>zz", { noremap = true, silent = true })

vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })

-- Resizing keymaps using Control + . , - =
-- Use Control + h/j/k/l to resize windows
vim.keymap.set("n", "<C-l>", "<C-w><", { desc = "Decrease width", silent = true })
vim.keymap.set("n", "<C-h>", "<C-w>>", { desc = "Increase width", silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>-", { desc = "Decrease height", silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>+", { desc = "Increase height", silent = true })
vim.keymap.set("n", "<M-j>", ":cn<CR>", { desc = "Goto next quickfix", silent = true })
vim.keymap.set("n", "<M-k>", ":cp<CR>", { desc = "Goto previous quickfix", silent = true })

local utils = require("config.utils")
local wk = require("which-key")
local ts = require("telescope.builtin")
--local test = require("neotest")
-- local git = require("neogit")
wk.add({

  { "<leader>m",    group = "Manage" },
  { "<leader>mp",    "<cmd>Lazy<cr>",                desc = "Manage plugins" },
  { "<leader>ml",    "<cmd>Mason<cr>",                desc = "Manage LSP" },


  { "<leader><cr>", utils.ex_in_dir(ts.git_files),        desc = "Search whole repo" },
  { "<leader>.",    utils.ex_in_dir(ts.find_files),       desc = "Search current dir" },
  -- { "<leader>/",    ts.find_files, desc = "Live grep in root" },
  { "<leader>,",    utils.ex_in_dir(ts.live_grep), desc = "Live grep in root" },
  { "<leader>.",    "<cmd>Telescope live_grep<cr>", desc = "Live grep in root" },

  -- --DIRECTORY
  -- { "<leader>d",    group = "directory" },
  -- {
  --   "<leader>dg",
  --   function()
  --     ts.live_grep({ cwd = vim.fn.expand("%:p:h") })
  --   end,
  --   desc = "Live grep in current dir",
  -- },
  --TEST

  --{ "<leader>t",    group = "test" },
  --{ "<leader>tt",   test.run.run(),       desc = "Search current dir" },

  -- FILES
  { "<leader>f",    group = "file" },
  { "<leader>ff",   utils.ex_in_dir(ts.find_files),       desc = "Search current dir" },
  -- { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep in root" },

  -- RUN
  { "<leader>r",  group = "Run" },
  { "<leader>rp", "<cmd>Telescope oldfiles<cr>",                               desc = "Recent files" },

  
  {
    "<leader>fg",
    function()
      ts.live_grep({ cwd = vim.fn.expand("%:p:h") })
    end,
    desc = "Live grep in current dir",
  },
  { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                               desc = "Recent files" },
  { "<leader>fp", "<cmd>CopyRelPath<cr>",                               desc = "Copy current file path" },
  -- { "<leader>fm",   ":Move ",                                                    desc = "Move/Rename current file" },
  { "<leader>fc", "<cmd>edit " .. vim.fn.stdpath("config") .. "/init.lua<cr>", desc = "Config" },

  -- TODO Project  files
  { "<leader>p",  group = "Project" },
  { "<leader>pf", "<cmd>Telescope find_files<cr>",                             desc = "Search repo" },
  { "<leader>pg", "<cmd>Telescope live_grep<cr>",                              desc = "Grep project" },

  
  -- BUFFERS
  { "<leader>`",  "<c-^>",                                                     desc = "Switch to last buffer" },
  { "<leader>b",  group = "Buffers" },
  { "<leader>bb", "<cmd>Telescope buffers<cr>",                                desc = "List buffers" },
  { "<leader>bd", "<cmd>bdelete<cr>",                                          desc = "Close buffer" },
  { "<leader>bn", "<cmd>bnext<cr>",                                            desc = "Next buffer" },
  { "<leader>bp", "<cmd>bprevious<cr>",                                        desc = "Previous buffer" },

  -- OPEN
  { "<leader>o",  group = "open" },
  {
    "<leader>oe",
    function()
      OpenExplorer()
    end,
    desc = "Open explorer",
  },

  -- OIL
  -- { "<leader>d",  group = "Dired" },
  { "<leader>of", "<cmd>Oil<cr>",                               desc = "Oil file manager" },
  { "<leader>op", "<cmd>Oil .<cr>",                             desc = "Oil in project root" },
  { "<leader>oh", "<cmd>Oil ~<cr>",                             desc = "Oil in home directory" },
  { "<leader>oD", "<cmd>Oil ~/dev<cr>",                         desc = "Oil in dev directory" },
  { "<leader>or", "<cmd>Oil ~/dev/work_repos<cr>",              desc = "Oil in work repos" },
  { "<leader>on", "<cmd>Oil ~/dev/notes<cr>",                   desc = "Oil in notes" },

  -- { "<leader>rT", require("dap-python").test_method,            desc = "Debug Test Method" },

  -- Move this
  -- { "<leader>rd", "<cmd> lua vim.diagnostic.open_float() <CR>", desc = "Open float" },

  -- GIT
  { "<leader>g",  group = "Git" },


  -- LSP Navigation
  { "<leader>c",  group = "LSP" },
  { "<leader>cd", vim.lsp.buf.definition,                       desc = "Go to definition" },
  { "<leader>cD", vim.lsp.buf.declaration,                      desc = "Go to declaration" },
  { "<leader>ci", vim.lsp.buf.implementation,                   desc = "Go to implementation" },
  { "<leader>ct", vim.lsp.buf.type_definition,                  desc = "Go to type definition" },
  { "<leader>cr", vim.lsp.buf.references,                       desc = "Find references" },
  { "<leader>cs", vim.lsp.buf.signature_help,                   desc = "Signature help" },
  { "<leader>cR", vim.lsp.buf.rename,                           desc = "Rename" },
  { "<leader>cf", vim.lsp.buf.format,                           desc = "Format" },
  { "<leader>ca", vim.lsp.buf.code_action,                      desc = "Code action" },
  { "<leader>ch", vim.lsp.buf.hover,                            desc = "Hover" },
  { "<leader>ck", vim.diagnostic.open_float,                    desc = "Show diagnostics" },
  { "<leader>cn", vim.diagnostic.goto_next,                     desc = "Next diagnostic" },
  { "<leader>cp", vim.diagnostic.goto_prev,                     desc = "Previous diagnostic" },
  -- { "<leader>cc", toggle_comment(),                             desc = "Toggle comment" },
  -- WINDOW MANAGEMENT
  { "<leader>w",  group = "Window" },
  { "<leader>wh", "<C-w>h",                                     desc = "Move to left window" },
  { "<leader>wj", "<C-w>j",                                     desc = "Move to bottom window" },
  { "<leader>wk", "<C-w>k",                                     desc = "Move to top window" },
  { "<leader>wl", "<C-w>l",                                     desc = "Move to right window" },
  { "<leader>w=", "<C-w>=",                                     desc = "Equalize window sizes" },
  { "<leader>wh", "<C-w>s",                                     desc = "Split window horizontally" },
  { "<leader>wv", "<C-w>v",                                     desc = "Split window vertically" },
  { "<leader>wq", "<C-w>q",                                     desc = "Close window" },
  { "<leader>wo", "<C-w>o",                                     desc = "Close other windows" },
  { "<lader>wT",  "<C-w>T",                                     desc = "Move window to new tab" },
  { "<leader>wx", "<C-w>x",                                     desc = "Swap with next window" },
  { "<leader>wH", "<C-w>H",                                     desc = "Move window to far left" },
  { "<leader>wJ", "<C-w>J",                                     desc = "Move window to very bottom" },
  { "<leader>wK", "<C-w>K",                                     desc = "Move window to very top" },
  { "<leader>wL", "<C-w>L",                                     desc = "Move window to far right" },
  { "<leader>wd", "<C-w>c",                                     desc = "Close window" },
  { "<leader>ww", "<C-w>w",                                     desc = "Go to next window" },
})
