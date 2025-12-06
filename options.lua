-- Enable line number and relative number
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse
vim.o.mouse = "a"

-- Disable showing the mode since it is visible in the status line anyway
vim.o.showmode = false

-- Enable break indent for line wrapping
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 100

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Show whitespace characters
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Show replacement text as replacements are typed
vim.o.inccommand = "split"

-- Highlight cursor line
vim.o.cursorline = true

-- Set minimum lines to hold above/below cursor
vim.o.scrolloff = 16

-- Enable ask confirmation when needed
vim.o.confirm = true

-- Enable Undotree short timestamps
vim.g.undotree_ShortIndicators = 1

-- Enable nerd font
-- vim.g.have_nerd_font = true

-- Change diff command to FC -- WINDOWS SPECIFIC
vim.g.undotree_DiffCommand = "FC"

-- Expand tabs to spaces
vim.o.expandtab = true
