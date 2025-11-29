-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Requirements --
require("--T.plugins")
require("--T.keymaps")
require("--T.options")

-- Enable nerd font
-- vim.g.have_nerd_font = true

-- Change diff command to FC -- WINDOWS SPECIFIC
vim.g.undotree_DiffCommand = "FC"
