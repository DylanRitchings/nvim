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

vim.g.autoformat = true


local wk = require("which-key")
local ts = require("telescope.builtin")
wk.add({
  { "<leader>l",    "<cmd>Lazy<cr>",                                             desc = "Manage plugins" },
  { "<leader><cr>", ex_in_dir(ts.git_files),                                     desc = "Search whole repo" },
  { "<leader>.",    ex_in_dir(ts.find_files),                                    desc = "Search current dir" },
  { "<leader>f",    group = "file" },
  { "<leader>ff",   "<cmd>Telescope find_files<cr>",                             desc = "Search current dir" },
  { "<leader>fb",   "<cmd>Telescope buffers<cr>",                                desc = "Buffers" },
  { "<leader>fd",   "<cmd>Dired<cr>",                                            desc = "Dired" },
  { "<leader>fm",   ":Move ",                                                    desc = "Move/Rename current file" },
  { "<leader>fc",   "<cmd>edit " .. vim.fn.stdpath("config") .. "/init.lua<cr>", desc = "Config" },

  -- GIT
  -- { "<leader>g",    group = "git" },
  -- { "<leader>ga",   ":Git add -u<cr>",                                           desc = "Add" },
  -- { "<leader>gb",   ":Git blame<cr>",                                            desc = "Blame" },
  -- { "<leader>gd",   ":Git diff<cr>",                                             desc = "Diff" },
  -- { "<leader>gp",   ":Git push<cr>",                                             desc = "Push" },
  -- { "<leader>gP",   ":Git pull<cr>",                                             desc = "Pull" },
  -- { "<leader>gc",   ":Git commit -m ",                                           desc = "Commit" },
  -- { "<leader>gs",   ":Git status<cr>",                                           desc = "Status" },
  --
  { "<leader>gq",   "Quick push",                                                desc = "Quick push" },
  { "<leader>dT",   require("dap-python").test_method,                           desc = "Debug Test Method" },
  { "<leader>o",    group = "open" },
  {
    "<leader>oe",
    function()
      OpenExplorer()
    end,
    desc = "Open explorer",
  },
  { "<leader>dd", "<cmd> lua vim.diagnostic.open_float() <CR>", desc = "Open float" },

  -- Oil
  { "<leader>oo", "<cmd>Oil<cr>",                               desc = "Open Oil" },
  { "<leader>of", "<cmd>Oil<cr>",                               desc = "Oil file manager" },
  { "<leader>op", "<cmd>Oil .<cr>",                             desc = "Oil in project root" },
  { "<leader>oh", "<cmd>Oil ~<cr>",                             desc = "Oil in home directory" }
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
