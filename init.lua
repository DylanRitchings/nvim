ROOT_DIR = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
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
vim.opt.mouse = 'a'
vim.env.GIT_WORK_TREE = vim.fn.getcwd()
vim.env.GIT_DIR = vim.fn.getcwd() .. "/.git"

vim.g.mapleader = " "
vim.g.lazyvim_python_lsp = "pyright"


vim.g.loaded_python3_provider = nil
vim.g.python3_host_prog = '/c/Program Files/Python312/python'

vim.cmd('runtime provider/python3.vim')

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

<<<<<<< HEAD
-- local function toggle_comment()
--   local line_comment = vim.bo.commentstring:match('^(.*)%%s') or '//'
--   local start_line = vim.fn.line("'<")
--   local end_line = vim.fn.line("'>")
--
--   for line = start_line, end_line do
--     local current_line = vim.fn.getline(line)
--     if current_line:match("^%s*" .. line_comment) then
--       vim.cmd(line .. "s/^\\(\\s*\\)" .. line_comment .. "/\\1/")
--     else
--       vim.cmd(line .. "s/^/" .. line_comment .. "/")
--     end
--   end
-- end
--

-- local function open_neogit_with_cwd()
--   local cwd = vim.fn.getcwd()
--   vim.cmd("Neogit cwd=" .. cwd)
-- end
vim.api.nvim_create_user_command("CopyRelPath", function()
  vim.fn.setreg('+', vim.fn.expand('%'))
end, {})

=======
vim.keymap.set("n", "s", "<Nop>", { noremap = true })
vim.keymap.set("x", "s", "<Nop>", { noremap = true })

require("mini.ai").setup()
require("mini.basics").setup()
require("mini.bufremove").setup()
require("mini.comment").setup()
require("mini.pairs").setup()
require("mini.icons").setup()
local mini_surround = require("mini.surround")
mini_surround.setup()
>>>>>>> 4a8aa14 (mac)
local wk = require("which-key")
local ts = require("telescope.builtin")
-- local test = require("neotest")
-- local git = require("neogit")
wk.add({

  { "<leader>m",    group = "Manage" },
  { "<leader>ml",    "<cmd>Lazy<cr>",                desc = "Manage plugins" },
  { "<leader>mm",    "<cmd>Mason<cr>",                desc = "Manage LSP" },


  { "<leader><cr>", ex_in_dir(ts.git_files),        desc = "Search whole repo" },
  { "<leader>.",    ex_in_dir(ts.find_files),       desc = "Search current dir" },
  { "<leader>/",    "<cmd>Telescope live_grep<cr>", desc = "Live grep in root" },

  --DIRECTORY
  { "<leader>d",    group = "directory" },
  {
    "<leader>dg",
    function()
      ts.live_grep({ cwd = vim.fn.expand("%:p:h") })
    end,
    desc = "Live grep in current dir",
  },
  --TEST

  -- { "<leader>t",    group = "test" },
  -- { "<leader>tt",   test.run.run(),       desc = "Search current dir" },

  -- FILES
  { "<leader>f",    group = "file" },
  { "<leader>ff",   ex_in_dir(ts.find_files),       desc = "Search current dir" },
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

<<<<<<< HEAD
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
  { "<leader>w<", "<C-w><",                                     desc = "Decrease width" },
  { "<leader>w>", "<C-w>>",                                     desc = "Increase width" },
  { "<leader>w-", "<C-w>-",                                     desc = "Decrease height" },
  { "<leader>w+", "<C-w>+",                                     desc = "Increase height" },
  { "<leader>w=", "<C-w>=",                                     desc = "Equalize window sizes" },
  { "<leader>ws", "<C-w>s",                                     desc = "Split window horizontally" },
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
=======
	-- WINDOW MANAGEMENT
	{ "<leader>w", group = "Window" },
	{ "<leader>wh", "<C-w>h", desc = "Move to left window" },
	{ "<leader>wj", "<C-w>j", desc = "Move to bottom window" },
	{ "<leader>wk", "<C-w>k", desc = "Move to top window" },
	{ "<leader>wl", "<C-w>l", desc = "Move to right window" },
	{ "<leader>w<", "<C-w><", desc = "Decrease width" },
	{ "<leader>w>", "<C-w>>", desc = "Increase width" },
	{ "<leader>w-", "<C-w>-", desc = "Decrease height" },
	{ "<leader>w+", "<C-w>+", desc = "Increase height" },
	{ "<leader>w=", "<C-w>=", desc = "Equalize window sizes" },
	{ "<leader>ws", "<C-w>s", desc = "Split window horizontally" },
	{ "<leader>wv", "<C-w>v", desc = "Split window vertically" },
	{ "<leader>wq", "<C-w>q", desc = "Close window" },
	{ "<leader>wo", "<C-w>o", desc = "Close other windows" },
	{ "<lader>wT", "<C-w>T", desc = "Move window to new tab" },
	{ "<leader>wx", "<C-w>x", desc = "Swap with next window" },
	{ "<leader>wH", "<C-w>H", desc = "Move window to far left" },
	{ "<leader>wJ", "<C-w>J", desc = "Move window to very bottom" },
	{ "<leader>wK", "<C-w>K", desc = "Move window to very top" },
	{ "<leader>wL", "<C-w>L", desc = "Move window to far right" },
	{ "<leader>wd", "<C-w>c", desc = "Close window" },
	{ "<leader>ww", "<C-w>w", desc = "Go to next window" },

	-- { "sa", mini_surround.add, desc = "Add surrounding" },
	-- { "sd", mini_surround.delete, desc = "Delete surrounding" },
	-- { "sr", mini_surround.replace, desc = "Replace surrounding" },
>>>>>>> 4a8aa14 (mac)
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
vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Auto select virtualenv Nvim open",
  pattern = "*",
  callback = function()
    local venv = string.format("%s/.venv", ROOT_DIR)
    if venv ~= "" then
      require("venv-selector").retrieve_from_cache()
    end
  end,
  once = true,
})

-- require("gitsigns").setup({
--   current_line_blame = true,
--   current_line_blame_opts = {
--     delay = 0,
--   },
-- })

require("lualine").setup()

vim.lsp.buf.format({ timeout_ms = 10000 })
local function open_cdk_docs()
  local word = vim.fn.expand("<cword>")
  local url = "https://docs.aws.amazon.com/cdk/api/v2/python/aws_cdk/" .. word .. ".html"
  local cmd = ""

  if vim.fn.has("mac") == 1 then
    cmd = "open"
  elseif vim.fn.has("unix") == 1 then
    cmd = "xdg-open"
  elseif vim.fn.has("win32") == 1 then
    cmd = "start"
  end

  if cmd ~= "" then
    vim.fn.system(cmd .. " " .. url)
  else
    print("Unsupported operating system")
  end
end

vim.api.nvim_set_keymap('n', '<leader>co', ':lua open_cdk_docs()<CR>', { noremap = true, silent = true })





local function telescope_grep_and_replace()
  -- Use Telescope for live_grep
  require('telescope.builtin').live_grep({
    prompt_title = "Live Grep (for replace)",
    attach_mappings = function(prompt_bufnr, map)
      -- Override the default 'enter' key to send results to quickfix
      map('i', '<CR>', function()
        require('telescope.actions').send_to_qflist(prompt_bufnr)
        require('telescope.actions').close(prompt_bufnr)
        
        -- Prompt for search and replace terms
        vim.ui.input({prompt = "Search term: "}, function(search_term)
          if search_term then
            vim.ui.input({prompt = "Replace with: "}, function(replace_term)
              if replace_term then
                -- Perform the substitution
                vim.cmd('cdo s/' .. search_term .. '/' .. replace_term .. '/g | update')
                print("Replacement complete!")
              end
            end)
          end
        end)
      end)
      return true
    end,
  })
end

-- Set up a command to call this function
vim.api.nvim_create_user_command('TelescopeGrepAndReplace', telescope_grep_and_replace, {})

-- Optionally, set up a keybinding
vim.keymap.set('n', '<leader>pr', telescope_grep_and_replace, { noremap = true, silent = true })
