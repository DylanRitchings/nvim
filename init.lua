ROOT_DIR = vim.fn.systemlist('git rev-parse --show-toplevel')[1]

function GetPdmVenvPath()
  local handle = io.popen("pdm venv list | grep 'in-project' | awk '{print $3}'")
  local result = handle:read("*a")
  handle:close()

  -- Remove trailing newline
  result = result:gsub("[\n\r]", "")

  if result ~= "" then
    return result
  else
    return nil
  end
end

vim.g.mapleader = " "
vim.g.lazyvim_python_lsp = "basedpyright"

require("config.lazy")

require("lazy").setup("plugins")

if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
  vim.opt.shell = "bash"
  vim.opt.shellcmdflag = "-c"
  vim.opt.shellxquote = ""
  vim.opt.shellslash = true
end

vim.g.lazydev_enabled = true

-- Basic settings
vim.o.timeout = true
vim.o.timeoutlen = 0
vim.opt.clipboard:append("unnamedplus")

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.g.python3_host_prog = "C:\\Users\\dylan.ritchings\\.pyenv\\pyenv-win\\shims\\python3"
vim.wo.conceallevel = 1
vim.g.autoformat = true


local function ex_in_dir(func)
  return function()
    func({ cwd = vim.fn.expand("%:p:h") })
  end
end

function OpenExplorer()
  local current_dir = vim.fn.expand("%:p:h")
  local cmd = string.format('cd "%s" && explorer .', current_dir)
  print(cmd)
  vim.fn.jobstart(cmd, { detach = true })
end

local wk = require("which-key")
local ts = require("telescope.builtin")
wk.add({
  { "<leader>l",    "<cmd>Lazy<cr>",                                               desc = "Manage plugins" },

  { "<leader><cr>", ex_in_dir(ts.git_files),                                       desc = "Search whole repo" },
  { "<leader>.",    ex_in_dir(ts.find_files),                                      desc = "Search current dir" },
  { "<leader>/",    "<cmd>Telescope live_grep<cr>",                                desc = "Live grep in root" },

  -- FILES
  { "<leader>f",    group = "file" },
  { "<leader>ff",   "<cmd>Telescope find_files<cr>",                               desc = "Search current dir" },
  { "<leader>fg",   "<cmd>Telescope live_grep<cr>",                                desc = "Live grep in root" },
  { "<leader>fG",   function() ts.live_grep({ cwd = vim.fn.expand('%:p:h') }) end, desc = "Live grep in current dir" },
  { "<leader>fr",   "<cmd>Telescope oldfiles<cr>",                                 desc = "Recent files" },
  -- { "<leader>fm",   ":Move ",                                                    desc = "Move/Rename current file" },
  { "<leader>fc",   "<cmd>edit " .. vim.fn.stdpath("config") .. "/init.lua<cr>",   desc = "Config" },

  -- BUFFERS
  { "<leader>`",    "<c-^>",                                                       desc = "Switch to last buffer" },
  { "<leader>b",    group = "Buffers" },
  { "<leader>bb",   "<cmd>Telescope buffers<cr>",                                  desc = "List buffers" },
  { "<leader>bd",   "<cmd>bdelete<cr>",                                            desc = "Close buffer" },
  { "<leader>bn",   "<cmd>bnext<cr>",                                              desc = "Next buffer" },
  { "<leader>bp",   "<cmd>bprevious<cr>",                                          desc = "Previous buffer" },

  -- OPEN
  { "<leader>o",    group = "open" },
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
  { "<leader>on", "<cmd>Oil ~/dev/notes<cr>",              desc = "Oil in notes" },

  -- RUN
  { "<leader>r",  group = "Run" },
  { "<leader>rT", require("dap-python").test_method,            desc = "Debug Test Method" },


  -- Move this
  { "<leader>rd", "<cmd> lua vim.diagnostic.open_float() <CR>", desc = "Open float" },

})



-- compile latex on save
vim.api.nvim_create_augroup("AutoPdf", {})
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.tex",
  group = "AutoPdf",
  callback = function()
    vim.cmd([[!latexmk -pdf -pv -xelatex]])
  end,
})

-- Scroll down half a screen and keep cursor in the middle
vim.api.nvim_set_keymap("n", "<C-D>", "<C-D>zz", { noremap = true, silent = true })

-- Scroll up half a screen and keep cursor in the middle
vim.api.nvim_set_keymap("n", "<C-U>", "<C-U>zz", { noremap = true, silent = true })

-- Enable line wrapping
vim.wo.wrap = true
vim.o.wrap = true
-- Preserve indentation when wrapping lines
vim.wo.breakindent = true

-- Specify a string to be displayed at the start of wrapped lines
vim.opt.showbreak = ">> "

-- Avoid breaking words when wrapping lines
vim.opt.linebreak = true
vim.o.linebreak = true



-- Venv

-- TODO change to when python file is opened
vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Auto select virtualenv Nvim open',
  pattern = '*',
  callback = function()
    local venv = string.format("%s/.venv", ROOT_DIR)
    if venv ~= '' then
      require('venv-selector').retrieve_from_cache()
    end
  end,
  once = true,
})
