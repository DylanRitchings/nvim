vim.g.mapleader = " "
require("config.lazy")


require("config.settings")
require("lazy").setup("plugins")
require("lualine").setup()
require("config.bindings")

require("config.utils")

