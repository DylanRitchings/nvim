local U = {}

function U.ex_in_dir(func)
  return function()
    func({ cwd = vim.fn.expand("%:p:h") })
  end
end

function U.OpenExplorer()
  local current_dir = vim.fn.expand("%:p:h")
  local cmd = string.format('cd "%s" && explorer .', current_dir)
  print(cmd)
  vim.fn.jobstart(cmd, { detach = true })
end

function U.open_cdk_docs()
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

-- vim.api.nvim_set_keymap('n', '<leader>co', U.open_cdk_docs, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>co', U.open_cdk_docs, { noremap = true, silent = true })


-- local function get_venv_in_repo_root()
--   local util = require("lspconfig.util")
--   local root = util.find_git_ancestor(vim.fn.getcwd())
--   if root then
--     local venv_path = root .. "/.venv"
--     if vim.fn.isdirectory(venv_path) == 1 then
--       return venv_path
--     end
--   end
--   return nil
-- end
-- require("dap-python").setup(get_venv_in_repo_root() or vim.fn.exepath("python"))
-- function U.GetPdmVenvPath()
--   local handle = io.popen("pdm venv list | grep 'in-project' | awk '{print $3}'")
--   local result = handle:read("*a")
--   handle:close()
--
--   -- Remove trailing newline
--   result = result:gsub("[\n\r]", "")
--
--   if result ~= "" then
--     return result
--   else
--     return nil
--   end
-- end
--
-- vim.api.nvim_create_user_command("CopyRelPath", function()
--   vim.fn.setreg('+', vim.fn.expand('%'))
-- end, {})
--
-- function U.telescope_grep_and_replace()
--   -- Use Telescope for live_grep
--   require('telescope.builtin').live_grep({
--     prompt_title = "Live Grep (for replace)",
--     attach_mappings = function(prompt_bufnr, map)
--       -- Override the default 'enter' key to send results to quickfix
--       map('i', '<CR>', function()
--         require('telescope.actions').send_to_qflist(prompt_bufnr)
--         require('telescope.actions').close(prompt_bufnr)
--
--         -- Prompt for search and replace terms
--         vim.ui.input({prompt = "Search term: "}, function(search_term)
--           if search_term then
--             vim.ui.input({prompt = "Replace with: "}, function(replace_term)
--               if replace_term then
--                 -- Perform the substitution
--                 vim.cmd('cdo s/' .. search_term .. '/' .. replace_term .. '/g | update')
--                 print("Replacement complete!")
--               end
--             end)
--           end
--         end)
--       end)
--       return true
--     end,
--   })
-- end
--
-- vim.api.nvim_create_user_command('TelescopeGrepAndReplace', U.telescope_grep_and_replace, {})
-- vim.keymap.set('n', '<leader>pr', U.telescope_grep_and_replace, { noremap = true, silent = true })

-- compile latex on save
vim.api.nvim_create_augroup("AutoPdf", {})
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.tex",
  group = "AutoPdf",
  callback = function()
    vim.cmd([[!latexmk -pdf -pv -xelatex]])
  end,
})

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

return U
