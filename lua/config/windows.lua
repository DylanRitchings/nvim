-- Windows (work machine) only. Loaded from settings.lua when running on
-- Windows_NT, so none of this reaches Mac or Linux.

-- Line ending handling: read both formats, default to DOS for new files
vim.o.fileformats = "dos,unix"  -- Can read both CRLF and LF
vim.o.fileformat = "dos"        -- New buffers default to CRLF
vim.o.fixendofline = false      -- Don't add missing end-of-line on save
vim.o.endofline = false         -- Don't add trailing newline at EOF

-- vim.g.python3_host_prog = '/c/Program Files/Python312/python'
vim.opt.shell = "bash"
vim.opt.shellcmdflag = "-c"
vim.opt.shellxquote = ""
vim.opt.shellslash = true

-- Read by lua/plugins/python.lua (dap-python) and lua/plugins/copilot.lua
PYTHON_PATH = "C:\\Program Files\\Python312\\python.exe"
COPILOT_PROXY = "http://webproxy-cloud.metoffice.gov.uk:8082"

-- Merged into coc-settings.json
vim.g.coc_user_config = { ["python.pythonPath"] = "/usr/bin/python3" }
